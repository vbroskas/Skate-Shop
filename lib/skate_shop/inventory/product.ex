defmodule SkateShop.Inventory.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :model, :string
    field :frame, :string
    field :main_image_url, :string
    field :description, :string
    field :price_usd, :integer
    field :sku, :string

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:sku, :model, :frame, :description, :price_usd, :main_image_url])
    |> validate_required([:sku, :model, :frame, :description, :price_usd, :main_image_url])
  end
end
