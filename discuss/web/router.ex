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

    get "/", TopicController, :index     # list all the topics in the main page
    #get "/", PageController, :index             # when there is a HTTP GET request, for the "/" root main page, activate the PageController module and the index finction.
    get "/topics/new", TopicController, :new   # when there is a get request to /topic/new we will execute the TopicController and run the function "new"
    post "/topics", TopicController, :create   #submiting the form
    # get "/topics", TopicController, :index     # list all the topics
  end

  # Other scopes may use custom stacks.
  # scope "/api", Discuss do
  #   pipe_through :api
  # end
end
