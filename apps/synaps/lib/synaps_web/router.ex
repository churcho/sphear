defmodule SynapsWeb.Router do
  use SynapsWeb, :router

  import SynapsWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {SynapsWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  ## Authentication routes
  scope "/", SynapsWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    #get "/register", UserRegistrationController, :new
    #post "/register", UserRegistrationController, :create
    get "/login", UserSessionController, :new
    post "/login", UserSessionController, :create
    #get "/reset_password", UserResetPasswordController, :new
    #post "/reset_password", UserResetPasswordController, :create
    #get "/reset_password/:token", UserResetPasswordController, :edit
    #put "/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/", SynapsWeb do
    pipe_through [:browser, :require_authenticated_user]

    live "/panel", PanelLive, :index

    live "/kategorier", CategoryLive.Index, :index
    live "/kategorier/ny", CategoryLive.Index, :new
    live "/kategorier/:id/edit", CategoryLive.Index, :edit

    live "/kategorier/:id", CategoryLive.Show, :show
    live "/kategorier/:id/visa/edit", CategoryLive.Show, :edit

    live "/tider", MissionLive.Index, :index
    live "/tider/ny", MissionLive.Index, :new
    live "/tider/:id/edit", MissionLive.Index, :edit

    live "/tider/:id", MissionLive.Show, :show
    live "/tider/:id/visa/edit", MissionLive.Show, :edit

    #get "/user/settings", UserSettingsController, :edit
    #put "/user/settings/update_password", UserSettingsController, :update_password
    #put "/user/settings/update_email", UserSettingsController, :update_email
    #get "/user/settings/confirm_email/:token", UserSettingsController, :confirm_email
  end

  scope "/", SynapsWeb do
    pipe_through [:browser]

    live "/", PageLive, :index
    get "/demo", DemoController, :index
    live "/chat", ChatLive, :index
    live "/demo2", Demo2Live, :index
    live "/demo3", Demo3Live, :index

    delete "/logout", UserSessionController, :delete
    #get "/user/confirm", UserConfirmationController, :new
    #post "/user/confirm", UserConfirmationController, :create
    #get "/user/confirm/:token", UserConfirmationController, :confirm
  end

  # Other scopes may use custom stacks.
  # scope "/api", SynapsWeb do
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
      live_dashboard "/dashboard", metrics: SynapsWeb.Telemetry
    end
  end
end
