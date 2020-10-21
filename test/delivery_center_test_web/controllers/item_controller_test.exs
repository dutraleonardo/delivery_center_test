defmodule DeliveryCenterTestWeb.ItemControllerTest do
  use DeliveryCenterTestWeb.ConnCase

  alias DeliveryCenterTest.Deliveries
  alias DeliveryCenterTest.Deliveries.Item

  @create_attrs %{
    external_code: "some external_code",
    name: "some name",
    price: "120.5",
    quantity: 42,
    total: "120.5"
  }
  @update_attrs %{
    external_code: "some updated external_code",
    name: "some updated name",
    price: "456.7",
    quantity: 43,
    total: "456.7"
  }
  @invalid_attrs %{external_code: nil, name: nil, price: nil, quantity: nil, total: nil}

  def fixture(:item) do
    {:ok, item} = Deliveries.create_item(@create_attrs)
    item
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all items", %{conn: conn} do
      conn = get(conn, Routes.item_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create item" do
    test "renders item when data is valid", %{conn: conn} do
      conn = post(conn, Routes.item_path(conn, :create), item: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.item_path(conn, :show, id))

      assert %{
               "id" => id,
               "external_code" => "some external_code",
               "name" => "some name",
               "price" => "120.5",
               "quantity" => 42,
               "total" => "120.5"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.item_path(conn, :create), item: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update item" do
    setup [:create_item]

    test "renders item when data is valid", %{conn: conn, item: %Item{id: id} = item} do
      conn = put(conn, Routes.item_path(conn, :update, item), item: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.item_path(conn, :show, id))

      assert %{
               "id" => id,
               "external_code" => "some updated external_code",
               "name" => "some updated name",
               "price" => "456.7",
               "quantity" => 43,
               "total" => "456.7"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, item: item} do
      conn = put(conn, Routes.item_path(conn, :update, item), item: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete item" do
    setup [:create_item]

    test "deletes chosen item", %{conn: conn, item: item} do
      conn = delete(conn, Routes.item_path(conn, :delete, item))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.item_path(conn, :show, item))
      end
    end
  end

  defp create_item(_) do
    item = fixture(:item)
    %{item: item}
  end
end
