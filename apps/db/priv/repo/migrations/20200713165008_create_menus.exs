defmodule Db.Repo.Migrations.CreateMenus do
  use Ecto.Migration

  def change do
    create table(:menus) do
      add :name, :string
      add :restaurant_id, references(:restaurants, on_delete: :nothing)

      timestamps()
    end

    alter table(:restaurants) do
      add :menus_order, {:array, :id}
    end

    create index(:menus, [:restaurant_id])
  end
end
