defmodule LiveDeckWeb.Router do
  use LiveDeckWeb, :router
  import Phoenix.LiveView.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_root_layout, {LiveDeckWeb.LayoutView, :root}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LiveDeckWeb do
    pipe_through :browser

    get "/style-guide", StyleGuideController, :index
    live "/", PresentationLive
    live "/remote", ControlLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", LiveDeckWeb do
  #   pipe_through :api
  # end
end
