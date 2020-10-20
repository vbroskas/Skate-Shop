defmodule SkateShop.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      SkateShop.Repo,
      # Start the Telemetry supervisor
      SkateShopWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: SkateShop.PubSub},
      # Start the Endpoint (http/https)
      SkateShopWeb.Endpoint
      # Start a worker by calling: SkateShop.Worker.start_link(arg)
      # {SkateShop.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SkateShop.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SkateShopWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
