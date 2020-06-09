defmodule MM.App do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      MM.Repo
    ]

    opts = [strategy: :one_for_one, name: MM.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
