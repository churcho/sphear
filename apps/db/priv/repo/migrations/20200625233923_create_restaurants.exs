defmodule Db.Repo.Migrations.CreateRestaurants do
  use Ecto.Migration

  def change do
    create table(:restaurants, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :url, :string
      add :address, :string

      timestamps()
    end

  end
end
