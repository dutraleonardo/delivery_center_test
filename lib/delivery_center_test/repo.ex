defmodule DeliveryCenterTest.Repo do
  use Ecto.Repo,
    otp_app: :delivery_center_test,
    adapter: Ecto.Adapters.Postgres
end
