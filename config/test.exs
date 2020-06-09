use Mix.Config

config :mm, MM.Repo,
  username: "postgres",
  database: "interview_mindmap_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
