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

  def search(user_id, parent_id, name) do
    search_query(user_id, parent_id, name)
    |> Repo.all()
  end

  def search_query(user_id, nil, name) do
    level_one = level_one_query(user_id, nil)

    from(
      x in Topic,
      where: is_nil(x.id) or is_nil(x.parent_id) or x.parent_id in subquery(level_one),
      where: x.user_id == ^user_id,
      where: ilike(x.name, ^"%#{name}%"),
      order_by: [asc: :inserted_at]
    )
  end

  def search_query(user_id, parent_id, name) do
    level_one = level_one_query(user_id, parent_id)

    from(
      x in Topic,
      where:
        x.id == ^parent_id or x.parent_id == ^parent_id or x.parent_id in subquery(level_one),
      where: x.user_id == ^user_id,
      where: ilike(x.name, ^"%#{name}%"),
      order_by: [asc: :inserted_at]
    )
  end

  def level_one_query(nil, nil) do
    from(x in Topic, where: is_nil(x.parent_id), select: [:id])
  end

  def level_one_query(nil, parent_id) do
    from(x in Topic, where: x.parent_id == ^parent_id, select: [:id])
  end

  def level_one_query(user_id, nil) do
    from(x in Topic, where: x.user_id == ^user_id and is_nil(x.parent_id), select: [:id])
  end

  def level_one_query(user_id, parent_id) do
    from(x in Topic, where: x.user_id == ^user_id and x.parent_id == ^parent_id, select: [:id])
  end
end
