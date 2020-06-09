defmodule MM.Schema.Topic do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [:name]
  @optional_fields [:parent_id]
  @fields @required_fields ++ @optional_fields

  @timestamps_opts [type: :utc_datetime_usec]
  schema "topics" do
    field(:name, :string)
    belongs_to(:user, MM.Schema.User)
    belongs_to(:parent, MM.Schema.Topic)
    timestamps()
  end

  @doc false
  def changeset(topic, attrs) do
    topic
    |> cast(attrs, @fields)
    |> validate_required(@required_fields)
  end
end
