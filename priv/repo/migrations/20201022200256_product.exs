defmodule SkateShop.Repo.Migrations.Product do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :sku, :string, null: false
      add :model, :string, null: false
      add :frame, :string, null: false
      add :description, :string, null: false
      add :price_usd, :integer, null: false
      add :main_image_url, :string, null: false

      timestamps(null: false)
    end
    create unique_index(:products, [:sku])

  end
end
