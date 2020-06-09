alias Ecto.Changeset

alias MM.Repo
alias MM.Schema.{Topic, User}

defmodule Seeds do
  def user!(name, email) do
    %User{}
    |> User.changeset(%{name: name, email: email})
    |> Repo.insert!()
  end

  def topic!(name, user, parent) do
    %Topic{}
    |> Topic.changeset(%{name: name, user: user, parent: parent})
    |> Changeset.put_assoc(:user, user)
    |> Changeset.put_assoc(:parent, parent)
    |> Repo.insert!()
  end
end

# --- Create users.

m1 = Seeds.user!("Michael", "michael@mm.org")
_m2 = Seeds.user!("Michelle", "michelle@mm.org")

# --- Create topics for one of the users.

lotr = Seeds.topic!("Lord of the Rings", m1, nil)

story = Seeds.topic!("Story", m1, lotr)
characters = Seeds.topic!("Characters", m1, lotr)
setting = Seeds.topic!("Setting", m1, lotr)

Seeds.topic!("Part I", m1, story)
Seeds.topic!("Part II", m1, story)
Seeds.topic!("Part III", m1, story)

Seeds.topic!("Arwen", m1, characters)
Seeds.topic!("Galadriel", m1, characters)
Seeds.topic!("Aragorn", m1, characters)
Seeds.topic!("Celeborn", m1, characters)
Seeds.topic!("Gimli", m1, characters)
Seeds.topic!("Legolas", m1, characters)
Seeds.topic!("Sam", m1, characters)
Seeds.topic!("Frodo", m1, characters)
Seeds.topic!("Merry", m1, characters)
Seeds.topic!("Pippin", m1, characters)
Seeds.topic!("Gandalf", m1, characters)

genres = Seeds.topic!("Genres", m1, setting)
races = Seeds.topic!("Races", m1, setting)
locations = Seeds.topic!("Locations", m1, setting)

Seeds.topic!("Fantasy", m1, genres)
Seeds.topic!("Fiction", m1, genres)
Seeds.topic!("Tale", m1, genres)

Seeds.topic!("Hobbits", m1, races)
Seeds.topic!("Humans", m1, races)
Seeds.topic!("Elves", m1, races)
Seeds.topic!("Dwarves", m1, races)
Seeds.topic!("Orcs", m1, races)

Seeds.topic!("The Shire", m1, locations)
Seeds.topic!("Bree", m1, locations)
Seeds.topic!("Isengard", m1, locations)
Seeds.topic!("Moria", m1, locations)
Seeds.topic!("Mordor", m1, locations)
