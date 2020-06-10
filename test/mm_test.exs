defmodule MMTest do
  use ExUnit.Case, async: true
  doctest MM

  alias MM.Repo
  alias MM.Schema.{Topic, User}

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
end
