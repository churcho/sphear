defmodule Db.Feeders.Menu do
  use Ecto.Schema
  import Ecto.Changeset

  alias Db.Feeders.Restaurant

  schema "menus" do
    field :name, :string

    belongs_to :restaurant, Restaurant

    timestamps()
  end

  @doc false
  def changeset(menu, attrs) do
    menu
    |> cast(attrs, [:name, :restaurant_id])
    |> validate_required([:name, :restaurant_id])
    |> assoc_constraint(:restaurant)
  end
end
