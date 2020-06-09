defmodule MM.Repo.Migrations.CreateTopics do
  use Ecto.Migration

  def change do
    create table(:topics) do
      add :name, :string, null: false
      add :user_id, references(:users), null: false
      add :parent_id, references(:topics)
      timestamps()
    end
  end
end
