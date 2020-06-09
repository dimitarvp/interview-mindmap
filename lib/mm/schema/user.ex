defmodule MM.Schema.User do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [:email, :name]
  @optional_fields []
  @fields @required_fields ++ @optional_fields

  @timestamps_opts [type: :utc_datetime_usec]
  schema "users" do
    field(:name, :string)
    field(:email, :string)
    has_many(:topics, MM.Schema.Topic)
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:email)
  end
end
