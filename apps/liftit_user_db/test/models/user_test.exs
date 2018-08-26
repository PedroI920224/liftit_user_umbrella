defmodule Models.UserTest do
  require IEx
  use ExUnit.Case
  alias LiftitUserDb.Models.User

  @valid_attrs %{address: "Av siempre viva 123", city: "Springfield", confirmed: true, country: "EEUU",
    email: "el_barto166@outlook.com", name: "Bart Simpson", password: "yonofui", password_hash: "yonofui", phone_number: "031-123456"}

  @repeat_attrs_by_email %{address: "Av siempre viva 456", city: "Bogotá", confirmed: true, country: "Colombia",
    email: "el_barto166@outlook.com", name: "Juan Sin Miedo", password: "yosifui", password_hash: "yosifui", phone_number: "031-123888"}

  @invalid_by_email_attrs %{address: "Av siempre viva 123", city: "Springfield", confirmed: true, country: "EEUU",
    email: "el_barto @ outlook.com", name: "Bart Simpson", password: "yonofui", password_hash: "yonofui", phone_number: "031-123456"}

  @invalid_by_match_passwords %{address: "Av siempre viva 123", city: "Springfield", confirmed: true, country: "EEUU",
    email: "el_barto@outlook.com", name: "Bart Simpson", password: "quemercoles", password_hash: "yonofui", phone_number: "031-123456"}

  @empty_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end 

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @empty_attrs)
    refute changeset.valid?
  end 

  test "changeset with invalid attributes by email" do
    changeset = User.changeset(%User{}, @invalid_by_email_attrs)
    refute changeset.valid?
  end 

  test "when the password and the password_hash don't match" do
    changeset = User.changeset(%User{}, @invalid_by_match_passwords)
    refute changeset.valid?
  end

  test "changeset is invalid if email is used already" do

   #%User{}
   #|> User.changeset(@valid_attrs)
   #|> LiftitUserDb.Repo.insert!

    user2 =
      %User{}
      |> User.changeset(@repeat_attrs_by_email)

    assert {:error, changeset} = LiftitUserDb.Repo.insert(user2)
    assert changeset.errors[:email] == {"has already been taken", []}
  end
end
