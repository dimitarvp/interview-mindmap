defmodule MMTest do
  use ExUnit.Case, async: true
  doctest MM

  alias MM.Repo
  alias MM.Schema.{Topic, User}
  alias MM.Topics

  import MM.Factory

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  test "create user and topic" do
    user = insert(:user)
    assert 1 == Repo.aggregate(User, :count, :id)

    insert(:topic, user: user)
    assert 1 == Repo.aggregate(Topic, :count, :id)
  end

  test "list all root topics of a user" do
    u1 = insert(:user)
    _u2 = insert(:user)

    root1 = insert(:topic, user: u1)
    root2 = insert(:topic, user: u1)
    root3 = insert(:topic, user: u1)

    _child1 = insert(:topic, user: u1, parent: root1)
    _child2 = insert(:topic, user: u1, parent: root1)
    _child3 = insert(:topic, user: u1, parent: root1)

    expected_names = names([root1, root2, root3])

    actual_names =
      Topics.roots_by_user_id(u1.id)
      |> names()

    assert expected_names == actual_names
  end

  defp names(list), do: Enum.map(list, & Map.get(&1, :name))
end
