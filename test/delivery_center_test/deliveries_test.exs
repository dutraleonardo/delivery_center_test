defmodule DeliveryCenterTest.DeliveriesTest do
  use DeliveryCenterTest.DataCase

  alias DeliveryCenterTest.Deliveries

  describe "orders" do
    alias DeliveryCenterTest.Deliveries.Order

    @valid_attrs %{city: "some city", complement: "some complement", country: "some country", delivery_fee: "120.5", district: "some district", dt_order_create: "some dt_order_create", external_code: "some external_code", latitude: "120.5", longitude: "120.5", number: 42, postal_code: "some postal_code", state: "some state", store_id: 42, street: "some street", sub_total: "120.5", total: "120.5", total_shipping: "120.5"}
    @update_attrs %{city: "some updated city", complement: "some updated complement", country: "some updated country", delivery_fee: "456.7", district: "some updated district", dt_order_create: "some updated dt_order_create", external_code: "some updated external_code", latitude: "456.7", longitude: "456.7", number: 43, postal_code: "some updated postal_code", state: "some updated state", store_id: 43, street: "some updated street", sub_total: "456.7", total: "456.7", total_shipping: "456.7"}
    @invalid_attrs %{city: nil, complement: nil, country: nil, delivery_fee: nil, district: nil, dt_order_create: nil, external_code: nil, latitude: nil, longitude: nil, number: nil, postal_code: nil, state: nil, store_id: nil, street: nil, sub_total: nil, total: nil, total_shipping: nil}

    def order_fixture(attrs \\ %{}) do
      {:ok, order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Deliveries.create_order()

      order
    end

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Deliveries.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Deliveries.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      assert {:ok, %Order{} = order} = Deliveries.create_order(@valid_attrs)
      assert order.city == "some city"
      assert order.complement == "some complement"
      assert order.country == "some country"
      assert order.delivery_fee == Decimal.new("120.5")
      assert order.district == "some district"
      assert order.dt_order_create == "some dt_order_create"
      assert order.external_code == "some external_code"
      assert order.latitude == Decimal.new("120.5")
      assert order.longitude == Decimal.new("120.5")
      assert order.number == 42
      assert order.postal_code == "some postal_code"
      assert order.state == "some state"
      assert order.store_id == 42
      assert order.street == "some street"
      assert order.sub_total == Decimal.new("120.5")
      assert order.total == Decimal.new("120.5")
      assert order.total_shipping == Decimal.new("120.5")
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Deliveries.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      assert {:ok, %Order{} = order} = Deliveries.update_order(order, @update_attrs)
      assert order.city == "some updated city"
      assert order.complement == "some updated complement"
      assert order.country == "some updated country"
      assert order.delivery_fee == Decimal.new("456.7")
      assert order.district == "some updated district"
      assert order.dt_order_create == "some updated dt_order_create"
      assert order.external_code == "some updated external_code"
      assert order.latitude == Decimal.new("456.7")
      assert order.longitude == Decimal.new("456.7")
      assert order.number == 43
      assert order.postal_code == "some updated postal_code"
      assert order.state == "some updated state"
      assert order.store_id == 43
      assert order.street == "some updated street"
      assert order.sub_total == Decimal.new("456.7")
      assert order.total == Decimal.new("456.7")
      assert order.total_shipping == Decimal.new("456.7")
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Deliveries.update_order(order, @invalid_attrs)
      assert order == Deliveries.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Deliveries.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Deliveries.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Deliveries.change_order(order)
    end
  end

  describe "customers" do
    alias DeliveryCenterTest.Deliveries.Customer

    @valid_attrs %{contact: "some contact", email: "some email", external_code: "some external_code", name: "some name"}
    @update_attrs %{contact: "some updated contact", email: "some updated email", external_code: "some updated external_code", name: "some updated name"}
    @invalid_attrs %{contact: nil, email: nil, external_code: nil, name: nil}

    def customer_fixture(attrs \\ %{}) do
      {:ok, customer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Deliveries.create_customer()

      customer
    end

    test "list_customers/0 returns all customers" do
      customer = customer_fixture()
      assert Deliveries.list_customers() == [customer]
    end

    test "get_customer!/1 returns the customer with given id" do
      customer = customer_fixture()
      assert Deliveries.get_customer!(customer.id) == customer
    end

    test "create_customer/1 with valid data creates a customer" do
      assert {:ok, %Customer{} = customer} = Deliveries.create_customer(@valid_attrs)
      assert customer.contact == "some contact"
      assert customer.email == "some email"
      assert customer.external_code == "some external_code"
      assert customer.name == "some name"
    end

    test "create_customer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Deliveries.create_customer(@invalid_attrs)
    end

    test "update_customer/2 with valid data updates the customer" do
      customer = customer_fixture()
      assert {:ok, %Customer{} = customer} = Deliveries.update_customer(customer, @update_attrs)
      assert customer.contact == "some updated contact"
      assert customer.email == "some updated email"
      assert customer.external_code == "some updated external_code"
      assert customer.name == "some updated name"
    end

    test "update_customer/2 with invalid data returns error changeset" do
      customer = customer_fixture()
      assert {:error, %Ecto.Changeset{}} = Deliveries.update_customer(customer, @invalid_attrs)
      assert customer == Deliveries.get_customer!(customer.id)
    end

    test "delete_customer/1 deletes the customer" do
      customer = customer_fixture()
      assert {:ok, %Customer{}} = Deliveries.delete_customer(customer)
      assert_raise Ecto.NoResultsError, fn -> Deliveries.get_customer!(customer.id) end
    end

    test "change_customer/1 returns a customer changeset" do
      customer = customer_fixture()
      assert %Ecto.Changeset{} = Deliveries.change_customer(customer)
    end
  end

  describe "items" do
    alias DeliveryCenterTest.Deliveries.Item

    @valid_attrs %{external_code: "some external_code", name: "some name", price: "120.5", quantity: 42, total: "120.5"}
    @update_attrs %{external_code: "some updated external_code", name: "some updated name", price: "456.7", quantity: 43, total: "456.7"}
    @invalid_attrs %{external_code: nil, name: nil, price: nil, quantity: nil, total: nil}

    def item_fixture(attrs \\ %{}) do
      {:ok, item} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Deliveries.create_item()

      item
    end

    test "list_items/0 returns all items" do
      item = item_fixture()
      assert Deliveries.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Deliveries.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      assert {:ok, %Item{} = item} = Deliveries.create_item(@valid_attrs)
      assert item.external_code == "some external_code"
      assert item.name == "some name"
      assert item.price == Decimal.new("120.5")
      assert item.quantity == 42
      assert item.total == Decimal.new("120.5")
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Deliveries.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      assert {:ok, %Item{} = item} = Deliveries.update_item(item, @update_attrs)
      assert item.external_code == "some updated external_code"
      assert item.name == "some updated name"
      assert item.price == Decimal.new("456.7")
      assert item.quantity == 43
      assert item.total == Decimal.new("456.7")
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Deliveries.update_item(item, @invalid_attrs)
      assert item == Deliveries.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Deliveries.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Deliveries.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Deliveries.change_item(item)
    end
  end

  describe "payments" do
    alias DeliveryCenterTest.Deliveries.Payment

    @valid_attrs %{type: "some type", value: "120.5"}
    @update_attrs %{type: "some updated type", value: "456.7"}
    @invalid_attrs %{type: nil, value: nil}

    def payment_fixture(attrs \\ %{}) do
      {:ok, payment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Deliveries.create_payment()

      payment
    end

    test "list_payments/0 returns all payments" do
      payment = payment_fixture()
      assert Deliveries.list_payments() == [payment]
    end

    test "get_payment!/1 returns the payment with given id" do
      payment = payment_fixture()
      assert Deliveries.get_payment!(payment.id) == payment
    end

    test "create_payment/1 with valid data creates a payment" do
      assert {:ok, %Payment{} = payment} = Deliveries.create_payment(@valid_attrs)
      assert payment.type == "some type"
      assert payment.value == Decimal.new("120.5")
    end

    test "create_payment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Deliveries.create_payment(@invalid_attrs)
    end

    test "update_payment/2 with valid data updates the payment" do
      payment = payment_fixture()
      assert {:ok, %Payment{} = payment} = Deliveries.update_payment(payment, @update_attrs)
      assert payment.type == "some updated type"
      assert payment.value == Decimal.new("456.7")
    end

    test "update_payment/2 with invalid data returns error changeset" do
      payment = payment_fixture()
      assert {:error, %Ecto.Changeset{}} = Deliveries.update_payment(payment, @invalid_attrs)
      assert payment == Deliveries.get_payment!(payment.id)
    end

    test "delete_payment/1 deletes the payment" do
      payment = payment_fixture()
      assert {:ok, %Payment{}} = Deliveries.delete_payment(payment)
      assert_raise Ecto.NoResultsError, fn -> Deliveries.get_payment!(payment.id) end
    end

    test "change_payment/1 returns a payment changeset" do
      payment = payment_fixture()
      assert %Ecto.Changeset{} = Deliveries.change_payment(payment)
    end
  end
end
