defmodule Db.Sales.Order do
  use Ecto.Schema
  import Ecto.Changeset

  alias Db.Accounts.User
  alias Db.Sales.Cart

  schema "orders" do
    field :state, :string, default: "created"
    
    field :started_at, :naive_datetime
    field :canceled_at, :naive_datetime
    field :completed_at, :naive_datetime
    
    belongs_to :user, User
    belongs_to :cart, Cart

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:user_id, :cart_id])
    |> validate_required([:user_id, :cart_id])
    |> assoc_constraint(:user, :cart)
  end

  @doc false
  def changeset_edit(order, attrs) do
    order
    |> cast(attrs, [:state])
  end
  
  use Fsmx.Struct, transitions: %{
    "created" => ["started", "canceled"],
    "started" => ["completed", "canceled"]
  }

  # save the timestamps between the transitions to db
  def transition_changeset(changeset, _, "started", _params) do
    # changeset already includes a :state field change
    changeset
    |> change(started_at: DateTime.utc_now())
  end
  def transition_changeset(changeset, _, "canceled", _params) do
    changeset
    |> change(canceled_at: DateTime.utc_now())
  end
  def transition_changeset(changeset, _, "completed", _params) do
    changeset
    |> change(completed_at: DateTime.utc_now())
  end
end
