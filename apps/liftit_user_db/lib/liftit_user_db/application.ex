defmodule LiftitUserDb.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      LiftitUserDb.Repo
      # {LiftitUserDb.Worker, arg},
    ]

    opts = [strategy: :one_for_one, name: LiftitUserDb.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
