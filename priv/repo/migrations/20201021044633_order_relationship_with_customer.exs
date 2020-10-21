defmodule DeliveryCenterTest.Repo.Migrations.OrderRelationshipWithCustomer do
  use Ecto.Migration

  # This migration create a foreign key between orders and customers
  def change do
    alter table(:orders) do
      add :customer_id, references(:customers)
    end
  end
end
