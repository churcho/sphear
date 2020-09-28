defmodule Db.Repo.Migrations.ProductSequence do
  use Ecto.Migration

  def change do
    alter table(:menus) do
      add :products_sequence, {:array, :binary_id}
    end
  end
end
