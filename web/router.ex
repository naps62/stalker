defmodule Stalker.Router do
  use Stalker.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Stalker do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    get "/stats/git", StatsController, :git
  end

  # Other scopes may use custom stacks.
  scope "/api", Stalker do
    pipe_through :api

    post "/git/enter", API.GitEventsController, :enter
    post "/git/exit", API.GitEventsController, :exit
  end
end
