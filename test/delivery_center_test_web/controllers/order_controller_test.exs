defmodule DeliveryCenterTestWeb.OrderControllerTest do
  use DeliveryCenterTestWeb.ConnCase

  alias DeliveryCenterTest.Deliveries
  alias DeliveryCenterTest.Deliveries.Order

  @create_attrs %{
    city: "some city",
    complement: "some complement",
    country: "some country",
    delivery_fee: "120.5",
    district: "some district",
    dt_order_create: "some dt_order_create",
    external_code: "some external_code",
    latitude: "120.5",
    longitude: "120.5",
    number: 42,
    postal_code: "some postal_code",
    state: "some state",
    store_id: 42,
    street: "some street",
    sub_total: "120.5",
    total: "120.5",
    total_shipping: "120.5"
  }
  @update_attrs %{
    city: "some updated city",
    complement: "some updated complement",
    country: "some updated country",
    delivery_fee: "456.7",
    district: "some updated district",
    dt_order_create: "some updated dt_order_create",
    external_code: "some updated external_code",
    latitude: "456.7",
    longitude: "456.7",
    number: 43,
    postal_code: "some updated postal_code",
    state: "some updated state",
    store_id: 43,
    street: "some updated street",
    sub_total: "456.7",
    total: "456.7",
    total_shipping: "456.7"
  }
  @invalid_attrs %{city: nil, complement: nil, country: nil, delivery_fee: nil, district: nil, dt_order_create: nil, external_code: nil, latitude: nil, longitude: nil, number: nil, postal_code: nil, state: nil, store_id: nil, street: nil, sub_total: nil, total: nil, total_shipping: nil}

  def fixture(:order) do
    {:ok, order} = Deliveries.create_order(@create_attrs)
    order
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all orders", %{conn: conn} do
      conn = get(conn, Routes.order_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create order" do
    test "renders order when data is valid", %{conn: conn} do
      conn = post(conn, Routes.order_path(conn, :create), order: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.order_path(conn, :show, id))

      assert %{
               "id" => id,
               "city" => "some city",
               "complement" => "some complement",
               "country" => "some country",
               "delivery_fee" => "120.5",
               "district" => "some district",
               "dt_order_create" => "some dt_order_create",
               "external_code" => "some external_code",
               "latitude" => "120.5",
               "longitude" => "120.5",
               "number" => 42,
               "postal_code" => "some postal_code",
               "state" => "some state",
               "store_id" => 42,
               "street" => "some street",
               "sub_total" => "120.5",
               "total" => "120.5",
               "total_shipping" => "120.5"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.order_path(conn, :create), order: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update order" do
    setup [:create_order]

    test "renders order when data is valid", %{conn: conn, order: %Order{id: id} = order} do
      conn = put(conn, Routes.order_path(conn, :update, order), order: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.order_path(conn, :show, id))

      assert %{
               "id" => id,
               "city" => "some updated city",
               "complement" => "some updated complement",
               "country" => "some updated country",
               "delivery_fee" => "456.7",
               "district" => "some updated district",
               "dt_order_create" => "some updated dt_order_create",
               "external_code" => "some updated external_code",
               "latitude" => "456.7",
               "longitude" => "456.7",
               "number" => 43,
               "postal_code" => "some updated postal_code",
               "state" => "some updated state",
               "store_id" => 43,
               "street" => "some updated street",
               "sub_total" => "456.7",
               "total" => "456.7",
               "total_shipping" => "456.7"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, order: order} do
      conn = put(conn, Routes.order_path(conn, :update, order), order: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete order" do
    setup [:create_order]

    test "deletes chosen order", %{conn: conn, order: order} do
      conn = delete(conn, Routes.order_path(conn, :delete, order))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.order_path(conn, :show, order))
      end
    end
  end

  defp create_order(_) do
    order = fixture(:order)
    %{order: order}
  end
end
