defmodule DeliveryCenterTest.Deliveries.Item do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Poison.Encoder, only: [:external_code, :name, :price, :quantity, :total]}
  schema "items" do
    field :external_code, :string
    field :name, :string
    field :price, :decimal
    field :quantity, :integer
    field :total, :decimal
    many_to_many :orders, DeliveryCenterTest.Deliveries.Order, join_through: "orders_items"

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:external_code, :name, :price, :quantity, :total])
    |> validate_required([:external_code, :name, :price, :quantity, :total])
  end
end
