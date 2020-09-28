defmodule Db.Repo.Migrations.CreateMissions do
  use Ecto.Migration

  def change do
    create table(:missions) do
      add :starts_at, :utc_datetime
      add :ends_at, :utc_datetime
      add :status, :string

      timestamps()
    end

  end
end
