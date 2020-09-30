defmodule Db.Repo.Migrations.CreateMissions do
  use Ecto.Migration

  def change do
    create table(:missions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :starts_at, :utc_datetime
      add :ends_at, :utc_datetime
      add :status, :string

      timestamps()
    end

  end
end
