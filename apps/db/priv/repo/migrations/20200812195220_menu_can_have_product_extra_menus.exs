defmodule Db.Repo.Migrations.MenuCanHaveProductExtraMenus do
  use Ecto.Migration

  def change do
    alter table(:product_extra_menus) do
      add(:menu_id, references(:menus, type: :binary_id, on_delete: :nothing))
    end
    
    create index(:product_extra_menus, [:menu_id])
  end
end
