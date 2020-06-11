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

  test "searching" do
    u1 = insert(:user)
    _u2 = insert(:user)

    t1 = insert(:topic, user: u1, name: "Call")
    t2 = insert(:topic, user: u1, name: "Toy")
    t3 = insert(:topic, user: u1, name: "Right")

    _t1_1 = insert(:topic, user: u1, parent: t1, name: "Hello")
    _t1_2 = insert(:topic, user: u1, parent: t1, name: "Hallo")
    _t1_3 = insert(:topic, user: u1, parent: t1, name: "Ollo")

    _t2_1 = insert(:topic, user: u1, parent: t2, name: "Night")
    _t2_2 = insert(:topic, user: u1, parent: t2, name: "Dwight")
    _t2_3 = insert(:topic, user: u1, parent: t2, name: "Boy")

    _t3_1 = insert(:topic, user: u1, parent: t3, name: "Soy")
    _t3_2 = insert(:topic, user: u1, parent: t3, name: "Wight")
    _t3_3 = insert(:topic, user: u1, parent: t3, name: "Might")

    assert ~w(Call Hello Hallo Ollo) ==
             search_names(u1.id, nil, "ll")

    assert ~w(Toy Boy Soy) ==
             search_names(u1.id, nil, "oy")

    assert ~w(Right Night Dwight Wight Might) ==
             search_names(u1.id, nil, "ight")

    assert ~w(Hello Hallo Ollo) ==
             search_names(u1.id, t1.id, "llo")

    assert ~w(Night Dwight) ==
             search_names(u1.id, t2.id, "ight")

    assert ~w(Toy Boy) ==
             search_names(u1.id, t2.id, "oy")

    assert ~w(Right Wight Might) ==
             search_names(u1.id, t3.id, "ight")

    assert ~w(Soy) ==
             search_names(u1.id, t3.id, "oy")
  end

  defp names(list), do: Enum.map(list, &Map.get(&1, :name))

  defp search_names(user_id, parent_id, name) do
    Topics.search(user_id, parent_id, name)
    |> names()
  end
end
