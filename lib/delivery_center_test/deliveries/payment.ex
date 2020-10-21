defmodule DeliveryCenterTest.Deliveries.Payment do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Poison.Encoder, only: [:type, :value]}
  schema "payments" do
    field :type, :string
    field :value, :decimal

    belongs_to :order, DeliveryCenterTest.Deliveries.Order

    timestamps()
  end

  @doc false
  def changeset(payment, attrs) do
    payment
    |> cast(attrs, [:type, :value])
    |> validate_required([:type, :value])
  end
end
