defmodule GamedropWeb.Router do
  use GamedropWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {GamedropWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :admin_layout do
    plug :put_layout, html: {GamedropWeb.Layouts, :admin}
  end

  scope "/", GamedropWeb do
    pipe_through [:browser, :admin_layout]
    get "/a", PageController, :admin
    resources "/gameplays", GameplayController
    resources "/consoles", ConsoleController
    resources "/games", GameController
  end

  scope "/", GamedropWeb do
    pipe_through :browser
    live "/", GameIdeaLive
    live "/a/:game", GameIdeaLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", GamedropWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:gamedrop, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: GamedropWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
