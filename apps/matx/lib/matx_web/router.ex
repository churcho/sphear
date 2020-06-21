defmodule MatxWeb.Router do
  use MatxWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {MatxWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Entrance.Login.Session
  end

  pipeline :protected do
    plug MatxWeb.Plugs.RequireLogin
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MatxWeb do
    pipe_through :browser

    get "/", PageController, :index
    live "/demo", PageLive, :index
    get "/button", PageController, :button

    # Accounts
    scope "/", Accounts do
      get "/user/new", UserController, :new
      post "/user/new", UserController, :create

      get "/session/new", SessionController, :new
      post "/session/new", SessionController, :create
      delete "/logout", SessionController, :delete
    end
  end

  scope "/protected", MatxWeb do
    pipe_through :browser
    pipe_through :protected

    get "/", PageController, :protected
  end

  # Other scopes may use custom stacks.
  # scope "/api", YourAppWeb do
  #   pipe_through :api
  # end

  # Other scopes may use custom stacks.
  # scope "/api", MatxWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: MatxWeb.Telemetry
    end
  end
end
