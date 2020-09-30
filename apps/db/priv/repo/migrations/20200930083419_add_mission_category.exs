defmodule Db.Repo.Migrations.AddMissionCategory do
  use Ecto.Migration

  def change do
    alter table(:missions) do
      add(:category_id, references(:categories, type: :binary_id, on_delete: :nothing))
    end
    
    create index(:missions, [:category_id])
  end
end
