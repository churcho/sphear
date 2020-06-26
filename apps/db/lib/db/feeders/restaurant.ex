defmodule Db.Feeders.Restaurant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "restaurants" do
    field :address, :string
    field :name, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(restaurant, attrs) do
    restaurant
    |> cast(attrs, [:name, :url, :address])
    |> validate_required([:name, :url, :address])
  end
end
