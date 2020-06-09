import Config

config :mm, MM.Repo,
  username: "postgres",
  database: "interview_mindmap_dev",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10,
  migration_timestamps: [type: :utc_datetime_usec]

config :logger, level: :warn
