use Mix.Config

config :liftit_user_db, LiftitUserDb.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "liftit_user_db_test",
  username: "postgres",
  password: "",
  hostname: "db",
  poolsize: 1,
  pool: Ecto.Adapters.SQL.Sandbox
