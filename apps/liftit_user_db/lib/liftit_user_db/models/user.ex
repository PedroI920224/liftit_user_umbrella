defmodule LiftitUserDb.Models.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :confirmed, :boolean
    field :phone_number, :string
    field :country, :string
    field :city, :string
    field :address, :string
    timestamps()
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:name, :email, :password, :password_hash, :phone_number, :country, :city, :address])
    |> validate_required([:name, :email, :password, :password_hash, :phone_number])
    |> validate_format(:email, ~r/\w+@+\w/)#begining with string and ending with string
    |> unique_constraint(:email)
    |> validate_required(~w(password)a)
    |> validate_password_confirmation()
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(password))
        _ -> changeset
    end
  end

  defp validate_password_confirmation(%{changes: changes} = changeset) do
    if changes[:password_hash] == changes[:password] do
      changeset
    else
      add_error(changeset, :password_hash, "must match password")
    end
  end

end
