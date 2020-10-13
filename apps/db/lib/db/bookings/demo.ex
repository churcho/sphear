defmodule Db.Bookings.Demo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "demo" do
    field :email, :string
    field :message, :string
    field :name, :string
    field :phone, :string

    timestamps()
  end

  @doc false
  def changeset(demo, attrs) do
    demo
    |> cast(attrs, [:name, :phone, :email, :message])
    |> validate_required([:name, :email, :message], message: "Måste fyllas i")
  end
end
