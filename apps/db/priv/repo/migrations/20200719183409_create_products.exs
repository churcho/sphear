defmodule Db.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :price, :integer
      add :menu_id, references(:menus, type: :binary_id, on_delete: :nothing)

      timestamps()
    end

    create index(:products, [:menu_id])
  end
end
