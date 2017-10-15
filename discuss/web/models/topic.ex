defmodule Discuss.Topic do
    use Discuss.Web, :model

    schema "topics" do
     field :title, :string

    end

    def changeset(struct, params \\ %{}) do
     # the "\\" indicate what is the default parameter of the param
        struct
        |> cast(params, [:title])
        |> validate_required(:title)
    end
    
end