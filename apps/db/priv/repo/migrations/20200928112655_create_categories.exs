defmodule Db.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string
      add :description, :string
      add :image, :string

      timestamps()
    end

  end
end
