defmodule DeliveryCenterTestWeb.CustomerView do
  use DeliveryCenterTestWeb, :view
  alias DeliveryCenterTestWeb.CustomerView

  def render("index.json", %{customers: customers}) do
    %{data: render_many(customers, CustomerView, "customer.json")}
  end

  def render("show.json", %{customer: customer}) do
    %{data: render_one(customer, CustomerView, "customer.json")}
  end

  def render("customer.json", %{customer: customer}) do
    %{id: customer.id,
      external_code: customer.external_code,
      name: customer.name,
      email: customer.email,
      contact: customer.contact}
  end
end
