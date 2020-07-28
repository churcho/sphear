defmodule Db.Repo.Migrations.AddExtrasToProduct do
  use Ecto.Migration

  def change do
    create table(:product_extra_menus) do
      add(:name, :string, null: false)
      add(:mandatory, :boolean, null: false, default: false)
      add(:pick_only_one, :boolean, null: false, default: false)
      add(:default_extra, :integer)

      add(:product_id, references(:products, on_delete: :nothing))
      timestamps()
    end

    create index(:product_extra_menus, [:product_id])
  end
end
