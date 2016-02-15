defmodule AskGary.Message do
  use AskGary.Web, :model

  schema "messages" do
    field :content, :string

    belongs_to :user, AskGary.User
    belongs_to :channel, AskGary.Channel

    timestamps
  end

  @required_fields ~w(content)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_length(:content, min: 1, max: 140)
  end
end
