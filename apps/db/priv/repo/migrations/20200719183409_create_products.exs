defmodule Db.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :price, :integer
      add :menu_id, references(:menus, on_delete: :nothing)

      timestamps()
    end

    create index(:products, [:menu_id])
  end
end
