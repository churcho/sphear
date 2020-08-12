defmodule Db.Repo.Migrations.OrdersCarts do
  use Ecto.Migration

  def change do
    create table(:carts) do
      add(:user_id, references(:users, on_delete: :nothing))

      timestamps()
    end

    create table(:discounts) do
      add(:flat_discount, :integer, default: 0)
      add(:percentage_discount, :integer, default: 0)
      add(:description, :text)
      add(:cart_id, references(:carts, on_delete: :nothing))

      timestamps()
    end

    create table(:cart_items) do
      add(:quantity, :integer, default: 1)
      add(:price, :integer)
      add(:cart_id, references(:carts, on_delete: :nothing))
      add(:product_id, references(:products, on_delete: :nothing))
      add(:product_extra_id, references(:product_extras, on_delete: :nothing))

      timestamps()
    end

    create table(:orders) do
      add(:state, :string, default: "created")
      add(:started_at, :naive_datetime)
      add(:canceled_at, :naive_datetime)
      add(:completed_at, :naive_datetime)
      add(:user_id, references(:users, on_delete: :nothing))
      add(:cart_id, references(:carts, on_delete: :nothing))
      
      timestamps()
    end

    create index(:carts, [:user_id])
    create index(:discounts, [:cart_id])
    create index(:cart_items, [:cart_id])
    create index(:cart_items, [:product_id])
    create index(:cart_items, [:product_extra_id])
    create index(:orders, [:user_id])
    create index(:orders, [:cart_id])
  end
end
