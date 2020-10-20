defmodule SkateShop.Repo do
  use Ecto.Repo,
    otp_app: :skate_shop,
    adapter: Ecto.Adapters.Postgres
end
