defmodule DeliveryCenterTest.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :external_code, :string
      add :store_id, :integer
      add :sub_total, :decimal
      add :delivery_fee, :decimal
      add :total_shipping, :decimal
      add :total, :decimal
      add :country, :string
      add :state, :string
      add :city, :string
      add :district, :string
      add :street, :string
      add :complement, :string
      add :latitude, :decimal
      add :longitude, :decimal
      add :dt_order_create, :string
      add :postal_code, :string
      add :number, :integer

      timestamps()
    end

  end
end
