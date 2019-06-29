defmodule MmoLiveviewWeb.Router do
  use MmoLiveviewWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Phoenix.LiveView.Flash
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MmoLiveviewWeb do
    pipe_through :browser

    get "/", PageController, :index
    live "/demo", ThermostatView
  end

  # Other scopes may use custom stacks.
  # scope "/api", MmoLiveviewWeb do
  #   pipe_through :api
  # end
end
