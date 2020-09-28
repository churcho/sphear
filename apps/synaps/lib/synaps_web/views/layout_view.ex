defmodule SynapsWeb.LayoutView do
  use SynapsWeb, :view

  @doc """
  Generates path for the JavaScript view we want to use
  in this combination of view/template.
  """
  def js_view_path(conn, nil) do
    String.slice(conn.request_path, 1..-1)
  end
  def js_view_path(conn, view_template) do
    module_name(to_string(view_template))
  end
  

  # Removes the SynapsWeb part and the Live part
  defp module_name(module) when is_binary(module) do
    module
    |> String.split(".")
    |> Enum.at(2)
    |> String.split("Live")
    |> Enum.at(0)
    |> String.downcase()
  end
end
