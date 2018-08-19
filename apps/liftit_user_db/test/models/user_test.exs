defmodule Models.UserTest do
  use ExUnit.Case
  alias LiftitUserDb.Models.User

  @valid_attrs %{address: "Av siempre viva 123", city: "Springfield", confirmed: true,
    country: "EEUU", email: "el_barto@outlook.com", name: "Bart Simpson", password: "yonofui",
    phone_number: "031-123456"}
  @invalid_by_email_attrs %{address: "Av siempre viva 123", city: "Springfield", confirmed: true,
    country: "EEUU", email: "el_barto @ outlook.com", name: "Bart Simpson", password: "yonofui",
    phone_number: "031-123456"}
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
end
