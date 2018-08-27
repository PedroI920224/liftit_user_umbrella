defmodule LiftitUserDb.User.Handler do

  alias LiftitUserDb.Models.User

  def try_saved_data(user_data) do
    user = Poison.decode!(user_data)
    changeset = User.changeset(%User{}, user)
    {status, body} = LiftitUserDb.Repo.insert(changeset)
    IO.puts "Hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhannnnnnnnnnnnnnnnddddddddddddllllllllllllllllllleeeeeeeeeeeeerrrrrrrrrrr"
    IO.inspect parser_errors(body.errors)
    IO.puts "Hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhannnnnnnnnnnnnnnnddddddddddddllllllllllllllllllleeeeeeeeeeeeerrrrrrrrrrr"
    IO.puts "Hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhannnnnnnnnnnnnnnnddddddddddddllllllllllllllllllleeeeeeeeeeeeerrrrrrrrrrr"
    case status do
      :ok -> {status, body}
      :error -> {status, parser_errors(body.errors)}
    end
  end

  def parser_errors(error_list) do
    Enum.map error_list, fn error ->
      case error do
        {:name, {"can't be blank", [validation: :required]}}  -> " Name can't be blank"
        {:email, {"can't be blank", [validation: :required]}} -> "Email can't be blank"
        {:password, {"can't be blank", [validation: :required]}} -> "Password can't be blank"
        {:password_hash, {"can't be blank", [validation: :required]}} -> "Confirm Password can't be blank"
        {:phone_number, {"can't be blank", [validation: :required]}} -> "Phone Number can't be blank"
        {:email, {"has invalid format", [validation: :format]}} -> "the Email has an invalid format"
        {:password_hash, {"must match password", []}} -> "Password and Confirm password must match"
        {:email, {"has already been taken", []}} -> "Has already one user with thats email"
         _-> "Invalid Params maybe name, email or password"
      end
    end
  end
end
