defmodule LiftitUserDb.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, null: false
      add :email, :string, null: false
      add :password_hash, :string, null: false
      add :confirmed, :boolean, default: false
      add :phone_number, :string, null: false
      add :country, :string
      add :city, :string
      add :address, :string

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
