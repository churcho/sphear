defmodule Db.Repo.Migrations.AddMissionInfo do
  use Ecto.Migration

  def change do
    alter table(:missions) do
      add :location, :string
      add :phone, :string
      add :email, :string
    end
  end
end
