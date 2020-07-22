Bureaucrat.start(
 writer: MatxWeb.MarkdownWriter,
 default_path: "README.md",
 paths: [],
 titles: [
   {MatxWeb.Channels.MerchandiseChannel, "channel merchandise:lobby"}, 
   {MatxWeb.Channels.RestaurantChannel, "channel restaurants:lobby"}, 
   {MatxWeb.Api.UserRegistrationController, "(REST) Register account"}, 
   {MatxWeb.Api.UserSessionController, "(REST) Login account"}
 ],
 env_var: "DOC",
 json_library: Jason
)
ExUnit.start(formatters: [ExUnit.CLIFormatter, Bureaucrat.Formatter])
Ecto.Adapters.SQL.Sandbox.mode(Db.Repo, :manual)
