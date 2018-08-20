defmodule LiftitUserWeb.UserControllerTest do
  use LiftitUserWeb.ConnCase

  alias LiftitUserWeb.User
  @valid_attrs %{address: "some address", city: "some city", confirmed: true, country: "some country", email: "some email", name: "some name", password: "some password", phone_number: "some phone_number"}
  @invalid_attrs %{}

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, user_path(conn, :new)
    assert html_response(conn, 200) =~ "New user"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @valid_attrs
    user = Repo.get_by!(User, @valid_attrs)
    assert redirected_to(conn) == user_path(conn, :show, user.id)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @invalid_attrs
    assert html_response(conn, 200) =~ "New user"
  end

 #test "shows chosen resource", %{conn: conn} do
 #  user = Repo.insert! %User{}
 #  conn = get conn, user_path(conn, :show, user)
 #  assert html_response(conn, 200) =~ "Show user"
 #end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, user_path(conn, :show, -1)
    end
  end
end
