defmodule LiftitUserWeb.UserView do
  use LiftitUserWeb.Web, :view

  def render("show.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      phone_number: user.phone_number,
      country: user.country,
      address: user.address
    }
  end

  def render("error.json", %{error: error}) do
    %{
      errors: error,
      advise: "please, to try again create an user redirect to http://localhost:4000/user/new"
    }
  end

end
