Bureaucrat.start(
 writer: MatxWeb.MarkdownWriter,
 default_path: "README.md",
 paths: [],
 titles: [{MatxWeb.Channels.RestaurantChannel, "channel restaurants"}],
 env_var: "DOC",
 json_library: Jason
)
ExUnit.start(formatters: [ExUnit.CLIFormatter, Bureaucrat.Formatter])
Ecto.Adapters.SQL.Sandbox.mode(Db.Repo, :manual)
