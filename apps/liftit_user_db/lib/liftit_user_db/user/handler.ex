defmodule LiftitUserDb.User.Handler do

  alias LiftitUserDb.Models.User

  def try_saved_data(user_data) do
    user = Poison.decode!(user_data)
    changeset = User.changeset(%User{}, user)
    {status, body} = LiftitUserDb.Repo.insert(changeset)
    case status do
      :ok -> {status, body}
      :error -> {status, "Invalid Params maybe name, email or password"}
    end
  end
end
