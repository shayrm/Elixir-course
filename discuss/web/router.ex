defmodule Discuss.Router do
  use Discuss.Web, :router

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

  scope "/", Discuss do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index   # when there is a HTTP GET request, for the "/" root main page, activate the PageController module and the index finction.
  end

  # Other scopes may use custom stacks.
  # scope "/api", Discuss do
  #   pipe_through :api
  # end
end
