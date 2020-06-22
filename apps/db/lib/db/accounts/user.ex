defmodule Db.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Entrance.Auth.Bcrypt, only: [hash_password: 1]

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :hashed_password, :string
    field :session_secret, :string

    timestamps()
  end

  def create_changeset(user \\ %Db.Accounts.User{}, attrs) do
    user
    |> cast(attrs, [:email, :password, :password_confirmation, :hashed_password, :session_secret])
    |> validate_required([:email, :password], message: "Fältet är tomt")
    |> validate_confirmation(:password, message: "Lösenorden matchar inte")
    |> hash_password
  end
end 