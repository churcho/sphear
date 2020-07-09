defmodule MatxWeb.RouterApi do
  use MatxWeb, :router

  import MatxWeb.UserAuth

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MatxWeb.Api, as: :api do
    pipe_through [:api]

    post "/login", UserSessionController, :create
    post "/logout", UserSessionController, :delete
    post "/register", UserRegistrationController, :create

    get "/restaurants", RestaurantController, :index
    get "/restaurant/:id", RestaurantController, :show
  end

  scope "/api", MatxWeb.Api do
    pipe_through [:api, :get_auth_token]

    get "/troll", TrollController, :troll
  end
end