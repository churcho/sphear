defmodule Db.Release do
    @moduledoc """
      Responsible for custom release commands
    """
    @app :db
  
    def create_and_migrate() do
      createdb()
      migrate()
    end

    def createdb() do
      for repo <- repos() do
        case repo.__adapter__.storage_up(repo.config) do
          :ok -> :ok
          {:error, :already_up} -> :ok
          {:error, term} -> {:error, term}
        end
      end
    end

    def migrate() do
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

    def createdb do
      # Start postgrex and ecto
      IO.puts "Starting dependencies..."
  
      # Start apps necessary for executing migrations
      Enum.each(@start_apps, &Application.ensure_all_started/1)
  
      Enum.each(@myapps, &create_db_for/1)
      IO.puts "createdb task done!"
  
    end
  
    def create_db_for(app) do
      for repo <- get_repos(app) do
        :ok = ensure_repo_created(repo)
      end
    end
  
    
  end