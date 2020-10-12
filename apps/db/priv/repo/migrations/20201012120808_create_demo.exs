defmodule Db.Repo.Migrations.CreateDemo do
  use Ecto.Migration

  def change do
    create table(:demo) do
      add :name, :string
      add :phone, :string
      add :email, :string
      add :message, :string

      timestamps()
    end

  end
end
