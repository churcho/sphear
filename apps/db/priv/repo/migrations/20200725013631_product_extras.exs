defmodule Db.Repo.Migrations.ProductExtras do
  use Ecto.Migration

  def change do
    create table(:product_extras) do
      add(:new_name, :string)
      add(:new_price, :integer)
      add(:hidden, :boolean, default: false)

      add(:product_id, references(:products, on_delete: :nothing))
      add(:product_extra_menu_id, references(:product_extra_menus, on_delete: :nothing))
      timestamps()
    end

    create index(:product_extras, [:product_extra_menu_id])
    create index(:product_extras, [:product_id])
  end
end
