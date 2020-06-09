import Config

config :mm,
  namespace: MM,
  ecto_repos: [MM.Repo]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

import_config "#{Mix.env()}.exs"
