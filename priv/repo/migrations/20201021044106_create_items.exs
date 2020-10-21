defmodule DeliveryCenterTest.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :external_code, :string
      add :name, :string
      add :price, :decimal
      add :quantity, :integer
      add :total, :decimal

      timestamps()
    end

  end
end
