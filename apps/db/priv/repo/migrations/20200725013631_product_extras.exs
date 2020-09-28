defmodule Db.Repo.Migrations.ProductExtras do
  use Ecto.Migration

  def change do
    create table(:product_extras, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add(:new_name, :string)
      add(:new_price, :integer)
      add(:hidden, :boolean, default: false)

      add(:product_id, references(:products, type: :binary_id, on_delete: :nothing))
      add(:product_extra_menu_id, references(:product_extra_menus, type: :binary_id, on_delete: :nothing))
      timestamps()
    end

    create index(:product_extras, [:product_extra_menu_id])
    create index(:product_extras, [:product_id])
  end
end
