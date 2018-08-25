defmodule BoundingBox.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  alias BoundingBox.Store
  alias BoundingBox.CarpoolStore

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: BoundingBox.Worker.start_link(arg)
      # {BoundingBox.Worker, arg},
     {Store, :coordinate_store},
     {CarpoolStore, :carpool}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BoundingBox.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
