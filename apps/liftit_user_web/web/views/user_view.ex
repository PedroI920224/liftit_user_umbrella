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
end
