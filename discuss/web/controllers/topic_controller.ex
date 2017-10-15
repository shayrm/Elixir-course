defmodule Discuss.TopicController do
  use Discuss.Web, :controller 
  alias Discuss.Topic
    
    def index(conn, _params) do
      topics = Repo.all(Topic)   # run select to all the list of topics stored in the DB
      render conn, "index.html", topics: topics
    end 
    
    def new(conn, _params) do
      # the conn is a struck object with the incomming and respond request.
      # the params can be used to parse the URL

      #since we have alias for the Discuss.Topic we can use just Topic
      #the long way
      #struct = %Topic{}
      #params = %{}
      #changeset = Topic.changeset(struct, params) 
      #create empty "changeset"
      changeset = Topic.changeset(%Topic{}, %{})
      render conn, "new.html", changeset: changeset

    end

    def create(conn, %{"topic" => topic}) do
      # we take only the topic string from the object
      # %{"topic" => topic} = params
      changeset = Topic.changeset(%Topic{}, topic)
      
      case Repo.insert(changeset) do
        {:ok, post} ->
          conn
          |> put_flash(:info, "Well done, topic Successfully created !!!")
          |> redirect(to: topic_path(conn, :index))
        
        {:error, changeset} -> 
          #render conn, "new.html", changeset: changeset ==> this is the old error msg.
          conn
          |> put_flash(:error, "There was an error, please try again !")
          |> redirect(to: topic_path(conn, :new))

      end
    end

    
end