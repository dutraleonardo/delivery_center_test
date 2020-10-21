defmodule DeliveryCenterTestWeb.OrderController do
  use DeliveryCenterTestWeb, :controller

  alias DeliveryCenterTest.Deliveries

  action_fallback DeliveryCenterTestWeb.FallbackController

  def create(conn, new_order) do
    {response, status_code} =
      case Deliveries.handle_new_order(new_order) do
        {:ok, message, status_code}  -> {%{:success => true, :message => message}, status_code}
        {:err, message, status_code} -> {%{:errors => true, :message => message}, status_code}
      end

    conn
    |> put_status(status_code)
    |> json(response)

  end
end
