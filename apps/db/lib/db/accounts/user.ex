defmodule Db.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Entrance.Auth.Bcrypt, only: [hash_password: 1]

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :hashed_password, :string
    field :session_secret, :string

    timestamps()
  end

  def create_changeset(user \\ %Db.Accounts.User{}, attrs) do
    user
    |> cast(attrs, [:email, :password, :hashed_password, :session_secret])
    |> validate_required([:email, :password])
    |> hash_password
  end
end 