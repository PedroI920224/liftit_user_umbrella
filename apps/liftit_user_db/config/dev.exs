use Mix.Config

config :liftit_user_db, LiftitUserDb.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "liftit_user_db_dev",
  username: "postgres",
  password: "",
  hostname: "db"
