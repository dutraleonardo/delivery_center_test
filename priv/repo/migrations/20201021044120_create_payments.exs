defmodule DeliveryCenterTest.Repo.Migrations.CreatePayments do
  use Ecto.Migration

  def change do
    create table(:payments) do
      add :type, :string
      add :value, :decimal

      timestamps()
    end

  end
end
