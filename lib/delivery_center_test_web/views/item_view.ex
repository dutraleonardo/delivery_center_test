defmodule DeliveryCenterTestWeb.ItemView do
  use DeliveryCenterTestWeb, :view
  alias DeliveryCenterTestWeb.ItemView

  def render("index.json", %{items: items}) do
    %{data: render_many(items, ItemView, "item.json")}
  end

  def render("show.json", %{item: item}) do
    %{data: render_one(item, ItemView, "item.json")}
  end

  def render("item.json", %{item: item}) do
    %{id: item.id,
      external_code: item.external_code,
      name: item.name,
      price: item.price,
      quantity: item.quantity,
      total: item.total}
  end
end
