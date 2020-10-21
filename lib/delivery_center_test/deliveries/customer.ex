defmodule DeliveryCenterTest.Deliveries.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Poison.Encoder, only: [:external_code, :name, :email, :contact]}
  schema "customers" do
    field :contact, :string
    field :email, :string
    field :external_code, :string
    field :name, :string

    has_many :orders, DeliveryCenterTest.Deliveries.Order
    timestamps()
  end

  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [:external_code, :name, :email, :contact])
    |> validate_required([:external_code, :name, :email, :contact])
  end
end
