defmodule LiftitUserWeb.UserController do
  use LiftitUserWeb.Web, :controller

  alias LiftitUserWeb.UserController.User

  def index(conn, _params) do
    users = Repo.all(User)
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = %{}
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    user_encoding = Poison.encode!(user_params)
    response = LiftitUserWeb.Rabbitmq.RpcClient.call(user_encoding)
    IO.puts "controlleeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeecontrolleeeerreeeeeee"
    IO.inspect response
    IO.puts "controlleeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeecontrolleeeerreeeeeee"
    case response do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User Created succesfully")
        |> redirect(to: user_path(conn, :show, user))
      {:error, message} ->
        conn
        |> put_flash(:error, message)
        |> render("new.html", changeset: %{})
    end

  end

  def show(conn, %{"id" => id}) do
    IO.puts "nuevaaaaamenteeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"
    IO.puts "nuevaaaaamenteeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"
    IO.puts "nuevaaaaamenteeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"
    IO.puts "nuevaaaaamenteeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"
  # user = Repo.get!(User, id)
  # render(conn, "show.html", user: user)
  # changeset = User.changeset(%User{}, user_params)
  # changeset = %{}
  # IO.puts user_params[:address]

  # render(conn, "new.html", changeset: changeset)
  # case Repo.insert(changeset) do
  #   {:ok, user} ->
  #     conn
  #     |> put_flash(:info, "User created successfully.")
  #     |> redirect(to: user_path(conn, :show, user))
  #   {:error, changeset} ->
  #     render(conn, "new.html", changeset: changeset)
  # end
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    render(conn, "show.html", user: user)
  end
end
