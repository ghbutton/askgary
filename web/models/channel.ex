defmodule AskGary.Channel do
  use AskGary.Web, :model

  schema "channels" do
    field :name, :string

    has_many :messages, AskGary.Message

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_length(:name, min: 2, max: 255)
  end
end
