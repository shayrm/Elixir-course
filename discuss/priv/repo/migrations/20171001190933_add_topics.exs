defmodule Discuss.Repo.Migrations.AddTopics do
  use Ecto.Migration
  @doc """"
  In this migration file we create a table named "topics"
  in the table we add a title colomn with string type
  """
  def change do
    create table(:topics) do
      add :title, :string

    end
  end
end
