defmodule LiftitUserWeb.UserControllerTest do
  use LiftitUserWeb.ConnCase

  alias LiftitUserWeb.User

  @valid_attrs %{address: "Av siempre viva 123", city: "Springfield", confirmed: true,
    country: "EEUU", email: "el_barto@outlook.com", name: "Bart Simpson", password: "yonofui", password_hash: "yonofui",
    phone_number: "031-123456"}

  @invalid_attrs %{}

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, user_path(conn, :new)
    assert html_response(conn, 200) =~ "New user"
  end

 #test "creates resource and redirects when data is valid", %{conn: conn} do
 #  conn = post conn, user_path(conn, :create), user: @valid_attrs
 # #user = Repo.get_by!(User, @valid_attrs)
 # #assert redirected_to(conn) == user_path(conn, :show, user.id)
 #end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    response = [" Name can't be blank", "Email can't be blank", "Password can't be blank", "Confirm Password can't be blank",
      "Phone Number can't be blank"]

    conn = build_conn
     |> post("/users", user: @invalid_attrs)
    body = conn |> response(400) |> Poison.decode!

   assert body["errors"] == response
  end

end
