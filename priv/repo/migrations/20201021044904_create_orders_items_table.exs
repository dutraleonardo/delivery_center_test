defmodule DeliveryCenterTest.Repo.Migrations.CreateOrdersItemsTable do
  use Ecto.Migration

  # This migration create a table to link orders and items
  def change do
    create table(:orders_items) do
      add :order_id, references(:orders)
      add :item_id, references(:items)
    end

    create unique_index(:orders_items, [:order_id, :item_id])
  end
end
