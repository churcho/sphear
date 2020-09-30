# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Db.Repo.insert!(%Db.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
#
# Enter iex console:
# _build/prod/rel/sphear/bin/sphear remote 
#
# Then run seeds.exs like this
# :code.priv_dir(:db)
# |> Path.join("repo/seeds.exs") 
# |> Code.require_file()

alias Db.Repo
alias Db.Feeders.{Restaurant, Menu}
alias Db.Merchandise.{Product, ProductExtra, ProductExtraMenu}
alias Db.Accounts

{:ok, user} = Accounts.register_user(%{email: "admin@synapsus.se", password: "test123"}) |> Accounts.set_admin()

restaurant = Repo.insert!(%Restaurant{name: "Tullinge Thai"})

# FÖRRÄTTER
menu = Repo.insert!(%Menu{name: "Förrätter", restaurant_id: restaurant.id})
Repo.insert!(%Product{name: "Tomyam Goong Gai", price: 70_00, menu_id: menu.id})
Repo.insert!(%Product{name: "Tomka Gai", price: 70_00, menu_id: menu.id})
Repo.insert!(%Product{name: "Popia Todd", price: 65_00, menu_id: menu.id})
Repo.insert!(%Product{name: "Satay Goong", price: 70_00, menu_id: menu.id})

satay_mo_gai = Repo.insert!(%Product{name: "Satay Mo Gai", price: 70_00, menu_id: menu.id})
product_extra_menu = Repo.insert!(%ProductExtraMenu{product_id: satay_mo_gai.id, name: "Storlek", mandatory: false, pick_only_one: true})
Repo.insert!(%ProductExtra{new_name: "Normal", new_price: 0, product_extra_menu_id: product_extra_menu.id})
Repo.insert!(%ProductExtra{new_name: "Stor", new_price: 40_00, product_extra_menu_id: product_extra_menu.id})

# JAPANSKA VARMRÄTTER
menu = Repo.insert!(%Menu{name: "Japanska Varmrätter", restaurant_id: restaurant.id})
Repo.insert!(%Product{name: "Yakitorispett", price: 90_00, menu_id: menu.id})
Repo.insert!(%Product{name: "Yakiniku", price: 105_00, menu_id: menu.id})
Repo.insert!(%Product{name: "Tori Pirakara", price: 90_00, menu_id: menu.id})
Repo.insert!(%Product{name: "Lax Teriyaki", price: 95_00, menu_id: menu.id})
Repo.insert!(%Product{name: "Tori Teriyaki", price: 100_00, menu_id: menu.id})
Repo.insert!(%Product{name: "Sushi med Yakiniku", price: 125_00, menu_id: menu.id})
Repo.insert!(%Product{name: "Bento Låda", price: 120_00, menu_id: menu.id})

# CURRY RÄTTER
menu = Repo.insert!(%Menu{name: "Curryrätter 🌶🌶", restaurant_id: restaurant.id})
Repo.insert!(%Product{name: "Goong pao wan Nua (Mo, Gai, Goong)", price: 110_00, menu_id: menu.id})
Repo.insert!(%Product{name: "Gaeng phed Nua (Mo, Gai, Goong)", price: 110_00, menu_id: menu.id})
Repo.insert!(%Product{name: "Gaeng panaeng Nua (Mo, Gai, Goong)", price: 110_00, menu_id: menu.id})
Repo.insert!(%Product{name: "Gaeng massaman Nua (Mo, Gai, Goong)", price: 110_00, menu_id: menu.id})
Repo.insert!(%Product{name: "Gaeng gari Mo (Gai, Goong)", price: 110_00, menu_id: menu.id})

menus_product_extra_menu = Repo.insert!(%ProductExtraMenu{menu_id: menu.id, name: "Storlek", mandatory: false, pick_only_one: true})
Repo.insert!(%ProductExtra{new_name: "Normal", new_price: 0, product_extra_menu_id: menus_product_extra_menu.id})
Repo.insert!(%ProductExtra{new_name: "Stor", new_price: 15_00, product_extra_menu_id: menus_product_extra_menu.id})





