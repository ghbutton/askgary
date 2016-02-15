defmodule AskGary.Router do
  use AskGary.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug AskGary.Auth, repo: AskGary.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AskGary do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController, only: [:index, :show, :new, :create]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    resources "/channels", ChannelController, only: [:index, :show]
  end

  # Other scopes may use custom stacks.
  # scope "/api", AskGary do
  #   pipe_through :api
  # end
end