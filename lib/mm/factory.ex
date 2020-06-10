defmodule MM.Factory do
  use ExMachina.Ecto, repo: MM.Repo

  def user_factory do
    %MM.Schema.User{
      name: Faker.Name.name(),
      email: Faker.Internet.email()
    }
  end

  def topic_factory do
    %MM.Schema.Topic{
      name: Faker.Lorem.word(),
      parent: nil
    }
  end
end
