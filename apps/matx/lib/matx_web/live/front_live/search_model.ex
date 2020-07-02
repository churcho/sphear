defmodule MatxWeb.SearchModel do
  defstruct restaurant: "", restaurants: [], loading: false, search_function: nil, info: nil, search: ""

  alias Db.Feeders

  def new(search_function: search_function) when is_function(search_function, 1) do
    {:ok, %__MODULE__{search_function: search_function}}
  end

  def new_restaurants(restaurants) do
    {:ok, %__MODULE__{restaurants: restaurants, search_function: &Feeders.suggest/1, loading: false}}
  end

  def new(_), do: {:error, "Query function must take one argument"}

  def prepare_query(%__MODULE__{} = struct, search) do
    struct
    |> store_search(search)
    |> set_loading_state
  end

  def execute_query(%__MODULE__{} = struct) do
    struct
    |> run_query
    |> clear_loading_state
  end

  defp run_query(%__MODULE__{search_function: search_function, search: search} = struct) do
    restaurants = search_function.(search)

    info =
      case restaurants do
        [] -> "Inga restauranger matchade via sökning: \"#{search}\""
        _ -> nil
      end

    struct
    |> Map.put(:restaurants, restaurants)
    |> Map.put(:info, info)
  end

  defp store_search(%__MODULE__{} = struct, search) do
    struct
    |> Map.put(:search, search)
  end

  defp set_loading_state(%__MODULE__{} = struct) do
    struct
    |> Map.put(:loading, true)
  end

  defp clear_loading_state(%__MODULE__{} = struct) do
    struct
    |> Map.put(:loading, false)
  end
end