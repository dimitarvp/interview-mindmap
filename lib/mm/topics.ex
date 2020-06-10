defmodule MM.Topics do
  alias MM.Repo
  alias MM.Schema.Topic
  import Ecto.Query

  def roots_by_user_id(user_id) do
    from(
      x in Topic,
      where: x.user_id == ^user_id,
      where: is_nil(x.parent_id),
      order_by: [asc: :inserted_at]
    )
    |> Repo.all()
  end
end
