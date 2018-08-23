defmodule LiftitUserDb.Models.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name     # Defaults to type :string
    field :email
    field :password
    field :confirmed, :boolean
    field :phone_number
    field :country
    field :city
    field :address
    timestamps
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:name, :email, :password, :phone_number, :country, :city, :address])
    |> validate_required([:name, :email, :password, :phone_number])
    |> validate_format(:email, ~r/\w+@+\w/)#begining with string
  end
end
