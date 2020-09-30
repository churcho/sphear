defmodule Db.Bookings.Category do
  use Db.Schema
  import Ecto.Changeset

  alias Db.Bookings.Mission

  schema "categories" do
    field :description, :string
    field :image, :string
    field :name, :string

    has_many :missions, Mission

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name, :description, :image])
    |> validate_required([:name, :description, :image])
  end
end
