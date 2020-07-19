defmodule Db.Repo.Migrations.Sequence do
  use Ecto.Migration

  def change do
    rename table(:restaurants),
      :menus_order, to: :menus_sequence
  end
end
