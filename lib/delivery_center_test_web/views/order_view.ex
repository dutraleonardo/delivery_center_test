defmodule DeliveryCenterTestWeb.OrderView do
  use DeliveryCenterTestWeb, :view
  alias DeliveryCenterTestWeb.OrderView

  def render("index.json", %{orders: orders}) do
    %{data: render_many(orders, OrderView, "order.json")}
  end

  def render("show.json", %{order: order}) do
    %{data: render_one(order, OrderView, "order.json")}
  end

  def render("order.json", %{order: order}) do
    %{id: order.id,
      external_code: order.external_code,
      store_id: order.store_id,
      sub_total: order.sub_total,
      delivery_fee: order.delivery_fee,
      total_shipping: order.total_shipping,
      total: order.total,
      country: order.country,
      state: order.state,
      city: order.city,
      district: order.district,
      street: order.street,
      complement: order.complement,
      latitude: order.latitude,
      longitude: order.longitude,
      dt_order_create: order.dt_order_create,
      postal_code: order.postal_code,
      number: order.number}
  end
end
