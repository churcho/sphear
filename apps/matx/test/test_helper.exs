Bureaucrat.start(
 writer: MatxWeb.MarkdownWriter,
 default_path: "README.md",
 paths: [],
 titles: [
   {MatxWeb.Channels.RestaurantChannel, "channel restaurants:lobby"},
   {MatxWeb.Channels.MerchandiseChannel, "channel merchandise:lobby"},
   {MatxWeb.Api.UserSessionController, "(REST) Login account"},
   {MatxWeb.Api.UserRegistrationController, "(REST) Register account"}
 ],
 env_var: "DOC",
 json_library: Jason
)
ExUnit.start(formatters: [ExUnit.CLIFormatter, Bureaucrat.Formatter])
Faker.start()
Ecto.Adapters.SQL.Sandbox.mode(Db.Repo, :manual)
