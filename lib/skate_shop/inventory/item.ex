defmodule SkateShop.Inventory.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :size, :string
    field :sku, :string
    belongs_to :product, SkateShop.Inventory.Product

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:sku, :size, :product_id])
    |> validate_required([:sku, :size, :product_id])
  end
end
