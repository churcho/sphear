defmodule Db.Repo.Migrations.HiddenFields do
  use Ecto.Migration

  def change do
    alter table(:menus) do
      add(:hidden, :boolean, default: true)
    end

    alter table(:restaurants) do
      add(:hidden, :boolean, default: true)
    end

    alter table(:products) do
      modify(:hidden, :boolean, default: true)
    end

    alter table(:product_extras) do
      modify(:hidden, :boolean, default: true)
    end

    alter table(:product_extra_menus) do
      add(:hidden, :boolean, default: true)
    end
  end
end
