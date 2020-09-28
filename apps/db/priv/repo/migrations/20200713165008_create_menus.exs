defmodule Db.Repo.Migrations.CreateMenus do
  use Ecto.Migration

  def change do
    create table(:menus, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :restaurant_id, references(:restaurants, type: :binary_id, on_delete: :nothing)

      timestamps()
    end

    alter table(:restaurants) do
      add :menus_order, {:array, :binary_id}
    end

    create index(:menus, [:restaurant_id])
  end
end
