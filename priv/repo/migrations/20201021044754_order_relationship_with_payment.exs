defmodule DeliveryCenterTest.Repo.Migrations.OrderRelationshipWithPayment do
  use Ecto.Migration

  # This migration create a foreign key between payments and orders
  def change do
    alter table(:payments) do
      add :order_id, references(:orders)
    end
  end
end
