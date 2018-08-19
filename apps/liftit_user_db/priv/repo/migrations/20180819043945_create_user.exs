defmodule LiftitUserDb.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, null: false
      add :email, :string, null: false
      add :password, :string, null: false
      add :confirmed, :boolean, default: false, null: false
      add :phone_number, :string, null: false
      add :country, :string
      add :city, :string
      add :address, :string

      timestamps()
    end

  end
end
