defmodule Db.Release do
    @moduledoc """
      Responsible for custom release commands
    """
    @app :db
  
    def create_and_migrate do
      Application.ensure_all_started(:ssl)
      createdb()
      migrate()
    end

    def createdb do
      for repo <- repos() do
        case repo.__adapter__.storage_up(repo.config) do
          :ok -> :ok
          {:error, :already_up} -> :ok
          {:error, term} -> {:error, term}
        end
      end
    end

    def migrate do
      for repo <- repos() do
        {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
      end
    end
  
    def rollback(repo, version) do
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
    end
  
    defp repos do
      Application.load(@app)
      Application.fetch_env!(@app, :ecto_repos)
    end
  end