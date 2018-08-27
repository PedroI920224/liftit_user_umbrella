defmodule User.HandlerTest do
  use ExUnit.Case
  alias LiftitUserDb.User.Handler

  test "should be compact the errors message" do
    errors = [
      name: {"can't be blank", [validation: :required]},
      email: {"can't be blank", [validation: :required]},
      password: {"can't be blank", [validation: :required]},
      password_hash: {"can't be blank", [validation: :required]},
      phone_number: {"can't be blank", [validation: :required]},
      email: {"has invalid format", [validation: :format]},
      password_hash: {"must match password", []},
      email: {"has already been taken", []}
    ]

    result = [
      " Name can't be blank", "Email can't be blank", "Password can't be blank", "Confirm Password can't be blank",
      "Phone Number can't be blank", "the Email has an invalid format", "Password and Confirm password must match",
      "Has already one user with thats email"
    ]

    assert Handler.parser_errors(errors) == result
  end
end
