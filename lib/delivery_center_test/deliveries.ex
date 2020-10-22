defmodule DeliveryCenterTest.Deliveries do
  @moduledoc """
  The Deliveries context.
  """
  require IEx
  import Ecto.Query, warn: false
  alias DeliveryCenterTest.Repo

  alias DeliveryCenterTest.Deliveries.{Customer, Item, Order, Payment}

  @doc """
  This function get a new order and execute a processing pipeline
  """
  def handle_new_order(new_order) do
    new_order
    |> request_parser
    |> save_data
    |> request_order_api
  end

  defp request_parser(request) do
    order = get_order_info(request)
    items = Enum.map(request["order_items"], &get_items_info/1)
    customer = get_customer_info(request)
    payments = Enum.map(request["payments"], &get_payment_info/1)

    %{:customer => customer, :items => items, :order => order, :payments => payments}
  end

  defp save_data(%{customer: customer, items: items, order: order, payments: payments}) do
    # save order
    order =
      customer
      |> Repo.insert!
      |> Ecto.build_assoc(:orders, order)
      |> Repo.insert!

    #save items
    items = Enum.map items, fn(item) -> Repo.insert!(item) end

    Repo.get(Order, order.id)
    |> Repo.preload(:items)
    |> Ecto.Changeset.change
    |> Ecto.Changeset.put_assoc(:items, items)
    |> Repo.update!

    #save payment
    _ = Enum.map payments, fn(item) ->
      Ecto.build_assoc(order, :payments, item) |> Repo.insert!
    end

    Repo.get!(Order, order.id)
      |> Repo.preload(:customer)
      |> Repo.preload(:items)
      |> Repo.preload(:payments)
  end

  defp request_order_api(order) do
    base_url = "https://delivery-center-recruitment-ap.herokuapp.com/"
    {:ok, convert_to_datetime} = Calendar.DateTime.now!("America/Fortaleza") |> Calendar.Strftime.strftime("%Hh%M - %d/%m/%y")
    headers = [{"X-Sent", convert_to_datetime}]
    payload = order |> Map.from_struct |> payload_format_parser |> Poison.encode!

    case HTTPoison.post(base_url, payload, headers) do
      {:ok, %HTTPoison.Response{status_code: status_code, body: body}} ->
        IEx.pry
        if status_code == 200, do: {
          :ok, body, status_code},
        else: {:err, body, status_code}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:err, "Not Found", 404}
      {:error, %HTTPoison.Error{reason: _reason}} ->
        {:err, "Service Unavailable", 503}
    end
  end

  defp payload_format_parser(order) do
    %{
      externalCode: order.external_code,
      storeId: order.store_id,
      subTotal: Decimal.to_float(order.sub_total),
      deliveryFee: Decimal.to_float(order.delivery_fee),
      total: Decimal.to_float(order.total),
      total_shipping: Decimal.to_float(order.total_shipping),
      country: order.country,
      state: order.state,
      city: order.city,
      district: order.district,
      street: order.street,
      complement: order.complement,
      latitude: Decimal.to_float(order.latitude),
      longitude: Decimal.to_float(order.longitude),
      dtOrderCreate: order.dt_order_create,
      postalCode: order.postal_code,
      number: order.number,
      customer: %{
        externalCode: order.customer.external_code,
        name: order.customer.name,
        email: order.customer.email,
        contact: order.customer.contact
      },
      items: Enum.map(order.items, fn(item) ->
        %{
          externalCode: item.external_code,
          name: item.name,
          price: Decimal.to_float(item.price),
          quantity: item.quantity,
          total: Decimal.to_float(item.total),
          subItems: []
        }
      end),
      payments: Enum.map(order.payments, fn(payment) ->
        %{
          type: payment.type,
          value: Decimal.to_float(payment.value)
        }
      end)
    }
  end

  defp get_order_info(request) do
    receiver_address = request["shipping"]["receiver_address"]
    {street_number, _base} = Integer.parse(receiver_address["street_number"])
    %Order{%Order{} |
      external_code: "#{request["id"]}",
      store_id: request["store_id"],
      sub_total: request["total_amount"],
      delivery_fee: request["total_shipping"],
      total: request["total_amount_with_shipping"],
      total_shipping: request["total_shipping"],
      country: receiver_address["country"]["id"],
      state: receiver_address["state"]["name"],
      city: receiver_address["city"]["name"],
      district: receiver_address["neighborhood"]["name"],
      street: receiver_address["street_name"],
      complement: receiver_address["comment"],
      latitude: receiver_address["latitude"],
      longitude: receiver_address["longitude"],
      dt_order_create: request["date_created"],
      postal_code: receiver_address["zip_code"],
      number: street_number
    }
  end

  def get_customer_info(request) do
    %Customer{%Customer{} |
      external_code: "#{request["buyer"]["id"]}",
      name: request["buyer"]["nickname"],
      email: request["buyer"]["email"],
      contact: "#{request["buyer"]["phone"]["area_code"]} #{request["buyer"]["phone"]["number"]}"
    }
  end

  defp get_items_info(order) do
    %Item{%Item{} |
      external_code: order["item"]["id"],
      name: order["item"]["title"],
      price: order["unit_price"],
      quantity: order["quantity"],
      total: order["full_unit_price"]
    }
  end

  defp get_payment_info(payment) do
    IEx.pry
    %Payment{%Payment{} |
      type: String.upcase(payment["payment_type"]),
      value: payment["total_paid_amount"]
    }
  end

end
