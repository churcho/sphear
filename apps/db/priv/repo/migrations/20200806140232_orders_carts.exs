defmodule Db.Repo.Migrations.OrdersCarts do
  use Ecto.Migration

  def change do
    create table(:carts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add(:user_id, references(:users, type: :binary_id, on_delete: :nothing))

      timestamps()
    end

    create table(:discounts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add(:flat_discount, :integer, default: 0)
      add(:percentage_discount, :integer, default: 0)
      add(:description, :text)
      add(:cart_id, references(:carts, type: :binary_id, on_delete: :nothing))

      timestamps()
    end

    create table(:cart_items, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add(:quantity, :integer, default: 1)
      add(:price, :integer)
      add(:cart_id, references(:carts, type: :binary_id, on_delete: :nothing))
      add(:product_id, references(:products, type: :binary_id, on_delete: :nothing))
      add(:product_extra_id, references(:product_extras, type: :binary_id, on_delete: :nothing))

      timestamps()
    end

    create table(:orders, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add(:state, :string, default: "created")
      add(:started_at, :naive_datetime)
      add(:canceled_at, :naive_datetime)
      add(:completed_at, :naive_datetime)
      add(:user_id, references(:users, type: :binary_id, on_delete: :nothing))
      add(:cart_id, references(:carts, type: :binary_id, on_delete: :nothing))
      
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
