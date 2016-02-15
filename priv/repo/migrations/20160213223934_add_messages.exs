defmodule AskGary.Repo.Migrations.AddMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :content, :text, null: false
      add :channel_id, references(:channels)
      add :user_id, references(:users)

      timestamps
    end
    create index(:messages, [:channel_id])
    create index(:messages, [:user_id])
  end
end
