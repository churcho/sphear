defmodule Db.Bookings.Mission do
  use Ecto.Schema
  import Ecto.Changeset

  schema "missions" do
    field :ends_at, :utc_datetime
    field :starts_at, :utc_datetime
    field :status, :string

    timestamps()
  end

  @doc false
  def changeset(mission, attrs) do
    mission
    |> cast(attrs, [:starts_at, :ends_at, :status])
    |> validate_required([:starts_at, :ends_at, :status])
  end
end
