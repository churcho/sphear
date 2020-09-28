defmodule Db.Repo.Migrations.AddRestaurantIdToProducts do
  use Ecto.Migration

  def change do
    alter table(:products) do
      add(:restaurant_id, references(:restaurants, type: :binary_id, on_delete: :nothing))
      add(:hidden, :boolean, default: false)
    end

    create index(:products, [:restaurant_id])
  end
end
