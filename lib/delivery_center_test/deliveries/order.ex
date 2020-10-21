defmodule DeliveryCenterTest.Deliveries.Order do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Poison.Encoder, only: [:external_code, :store_id, :sub_total, :delivery_fee, :total_shipping, :total, :country, :state, :city, :district, :street, :complement, :latitude, :longitude, :dt_order_create, :postal_code, :number, :customer, :item, :payments]}
  schema "orders" do
    field :city, :string
    field :complement, :string
    field :country, :string
    field :delivery_fee, :decimal
    field :district, :string
    field :dt_order_create, :string
    field :external_code, :string
    field :latitude, :decimal
    field :longitude, :decimal
    field :number, :integer
    field :postal_code, :string
    field :state, :string
    field :store_id, :integer
    field :street, :string
    field :sub_total, :decimal
    field :total, :decimal
    field :total_shipping, :decimal

    belongs_to :customer, DeliveryCenterTest.Deliveries.Customer
    many_to_many :items, DeliveryCenterTest.Deliveries.Item, join_through: "orders_items"
    has_many :payments, DeliveryCenterTest.Deliveries.Payment

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:external_code, :store_id, :sub_total, :delivery_fee, :total_shipping, :total, :country, :state, :city, :district, :street, :complement, :latitude, :longitude, :dt_order_create, :postal_code, :number])
    |> validate_required([:external_code, :store_id, :sub_total, :delivery_fee, :total_shipping, :total, :country, :state, :city, :district, :street, :complement, :latitude, :longitude, :dt_order_create, :postal_code, :number])
  end
end
