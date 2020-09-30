defmodule Db.Bookings.Mission do
  use Db.Schema
  import Ecto.Changeset

  alias Db.Bookings.Category

  schema "missions" do
    field :ends_at, :utc_datetime
    field :starts_at, :utc_datetime
    field :status, :string, default: "Ledig"
    field :location, :string, default: "Kransen"
    field :phone, :string
    field :email, :string

    belongs_to :category, Category, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(mission, attrs) do
    mission
    |> cast(attrs, [:category_id, :starts_at, :ends_at, :status, :location, :phone, :email])
    |> validate_required([:starts_at, :ends_at, :category_id])
    |> assoc_constraint(:category)
  end
end
