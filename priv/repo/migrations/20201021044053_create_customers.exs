defmodule DeliveryCenterTest.Repo.Migrations.CreateCustomers do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :external_code, :string
      add :name, :string
      add :email, :string
      add :contact, :string

      timestamps()
    end

  end
end
