# Channel Authentication

Websocket URL: [wss://matx.se/socket/websocket](wss://matx.se/socket/websocket)

In this API spec, each endpoint is a channel and each channel might need authentication (token parameter), but some endpoints will have guest functionality though.

When subscribing to a endpoint, connect and subscribe to the topic "lobby" with or without a token.

The endpoint will reply with either:
#### Subscribed to lobby without a token
```json
{
  "guest_success": true,
  "user_id": null
}
```
## or 
#### Subscribed to lobby with a token
```json
{
  "login_success": true,
  "user_id": 1
}
```
---



# Endpoints


  * [(REST) Login account](#rest-login-account)
    * [rest-login-account-create](#rest-login-account-create)
  * [(REST) Register account](#rest-register-account)
    * [rest-register-account-create](#rest-register-account-create)
  * [channel restaurants:lobby](#channel-restaurants-lobby)
    * [test actions - ping](#channel-restaurants-lobby-test-actions-ping)
    * [test actions - ensure logged in correctly](#channel-restaurants-lobby-test-actions-ensure-logged-in-correctly)
    * [guest actions - get all restaurants](#channel-restaurants-lobby-guest-actions-get-all-restaurants)
    * [guest actions - get one restaurant](#channel-restaurants-lobby-guest-actions-get-one-restaurant)
    * [guest actions - get all menus from a restaurant](#channel-restaurants-lobby-guest-actions-get-all-menus-from-a-restaurant)
    * [guest actions - get one menu](#channel-restaurants-lobby-guest-actions-get-one-menu)
    * [user actions - create a restaurant](#channel-restaurants-lobby-user-actions-create-a-restaurant)
    * [user actions - update a restaurant](#channel-restaurants-lobby-user-actions-update-a-restaurant)
    * [user actions - delete a restaurant](#channel-restaurants-lobby-user-actions-delete-a-restaurant)
    * [user actions - create a menu](#channel-restaurants-lobby-user-actions-create-a-menu)
    * [user actions - update a menu](#channel-restaurants-lobby-user-actions-update-a-menu)
    * [user actions - delete a menu](#channel-restaurants-lobby-user-actions-delete-a-menu)
    * [user actions - change sequence of menu](#channel-restaurants-lobby-user-actions-change-sequence-of-menu)
  * [channel merchandise:lobby](#channel-merchandise-lobby)
    * [test actions - ping](#channel-merchandise-lobby-test-actions-ping)
    * [test actions - ensure logged in correctly](#channel-merchandise-lobby-test-actions-ensure-logged-in-correctly)
    * [guest actions - get products from menu](#channel-merchandise-lobby-guest-actions-get-products-from-menu)
    * [user actions - create a product](#channel-merchandise-lobby-user-actions-create-a-product)
    * [user actions - create a unlisted product](#channel-merchandise-lobby-user-actions-create-a-unlisted-product)
    * [user actions - update a product](#channel-merchandise-lobby-user-actions-update-a-product)
    * [user actions - delete a product](#channel-merchandise-lobby-user-actions-delete-a-product)
    * [user actions - change sequence of product](#channel-merchandise-lobby-user-actions-change-sequence-of-product)
    * [user actions - create a product extra menu](#channel-merchandise-lobby-user-actions-create-a-product-extra-menu)
    * [user actions - update a product extra menu](#channel-merchandise-lobby-user-actions-update-a-product-extra-menu)
    * [user actions - delete a product extra menu](#channel-merchandise-lobby-user-actions-delete-a-product-extra-menu)
    * [user actions - create a product extra](#channel-merchandise-lobby-user-actions-create-a-product-extra)
    * [user actions - update a product extra](#channel-merchandise-lobby-user-actions-update-a-product-extra)
    * [user actions - delete a product extra](#channel-merchandise-lobby-user-actions-delete-a-product-extra)

# <a id=rest-login-account></a>(REST) Login account
## <a id=rest-login-account-create></a>rest-login-account-create
#
### POST /login - LOGIN SUCCESS
##### → <ins>Request</ins>
* __Method:__ POST
* __Path:__ /api/login
* __Request headers:__
```
content-type: multipart/mixed; boundary=plug_conn_test
```
* __Request body:__
```json
{
  "email": "user-576460752303420031@example.com",
  "password": "hello world!"
}
```

##### ← <ins>Response to you</ins>
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FiZKt_pJVQC-Dh0AAA2h
```
* __Response body:__
```json
{
  "success": {
    "token": "kL4WMx3DuiK8MULG02Xnw5Q53FimkucnmSty2nOs6Z0="
  }
}
```

#
### POST /login - LOGIN FAIL
##### → <ins>Request</ins>
* __Method:__ POST
* __Path:__ /api/login
* __Request headers:__
```
content-type: multipart/mixed; boundary=plug_conn_test
```
* __Request body:__
```json
{
  "email": "user-576460752303420255@example.com",
  "password": "lol"
}
```

##### ← <ins>Response to you</ins>
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FiZKt_PKH8AnG-UAAA1h
```
* __Response body:__
```json
{
  "error": "Fel användarnamn eller lösenord"
}
```

---
# <a id=rest-register-account></a>(REST) Register account
## <a id=rest-register-account-create></a>rest-register-account-create
#
### POST /register - REGISTER SUCCESS
##### → <ins>Request</ins>
* __Method:__ POST
* __Path:__ /api/register
* __Request headers:__
```
content-type: multipart/mixed; boundary=plug_conn_test
```
* __Request body:__
```json
{
  "email": "user-576460752303419934@example.com",
  "password": "hello world!",
  "password_confirmation": "hello world!"
}
```

##### ← <ins>Response to you</ins>
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FiZKt_s9eQA6_4UAAA4C
```
* __Response body:__
```json
{
  "success": {
    "email": "user-576460752303419934@example.com",
    "token": "SOyGvKCwRy0o7WlTRxW7VTvrErY2wWNnNRAD1ijyjak="
  }
}
```

#
### POST /register - REGISTER FAIL
##### → <ins>Request</ins>
* __Method:__ POST
* __Path:__ /api/register
* __Request headers:__
```
content-type: multipart/mixed; boundary=plug_conn_test
```
* __Request body:__
```json
{
  "email": "with spaces",
  "password": "lol",
  "password_confirmation": "lol"
}
```

##### ← <ins>Response to you</ins>
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FiZKt_PKH8DVutEAAA3C
```
* __Response body:__
```json
{
  "error": {
    "errors": {
      "email": [
        "must have the @ sign and no spaces"
      ],
      "password": [
        "should be at least 5 character(s)"
      ]
    }
  }
}
```

---
# <a id=channel-restaurants-lobby></a>channel restaurants:lobby
## <a id=channel-restaurants-lobby-test-actions-ping></a>test actions - ping
#### → <ins>Message to server</ins>
* __Topic:__ restaurants:lobby
* __Event:__ ping
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "pong"
}
```
---
## <a id=channel-restaurants-lobby-test-actions-ensure-logged-in-correctly></a>test actions - ensure logged in correctly
#### → <ins>Message to server</ins>
* __Topic:__ restaurants:lobby
* __Event:__ logged_in
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "user_id": 50129
}
```
---
## <a id=channel-restaurants-lobby-guest-actions-get-all-restaurants></a>guest actions - get all restaurants
#### → <ins>Message to server</ins>
* __Topic:__ restaurants:lobby
* __Event:__ get_restaurants
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "restaurants": [
      {
        "address": "526 Dewayne Key",
        "created": "2020-07-29T17:54:33",
        "id": 39922,
        "menus": [],
        "name": "Ron’s Pizza Hovel",
        "unlisted_products": [],
        "url": "https://rons-pizza-hovel.se"
      },
      {
        "address": "8770 Dominique Prairie",
        "created": "2020-07-29T17:54:33",
        "id": 39923,
        "menus": [],
        "name": "Mona Pizza",
        "unlisted_products": [],
        "url": "https://mona-pizza.se"
      },
      {
        "address": "3 Waldo Passage",
        "created": "2020-07-29T17:54:33",
        "id": 39924,
        "menus": [],
        "name": "Family Bros. Pizza",
        "unlisted_products": [],
        "url": "https://family-bros.-pizza.se"
      }
    ]
  }
}
```
---
## <a id=channel-restaurants-lobby-guest-actions-get-one-restaurant></a>guest actions - get one restaurant
#### → <ins>Message to server</ins>
* __Topic:__ restaurants:lobby
* __Event:__ get_restaurant
* __Body:__
```json
{
  "restaurant_id": 39909
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "address": "7201 Trinity Courts",
    "created": "2020-07-29T17:54:33",
    "id": 39909,
    "menus": [
      {
        "id": 11607,
        "name": "Italian Deli",
        "products": [
          {
            "hidden": false,
            "id": 5279,
            "inserted_at": "2020-07-29T17:54:33",
            "menu_id": 11607,
            "name": "10\" Greek with Chili Sauce and Ham",
            "price": {
              "amount": 7337,
              "currency": "SEK"
            },
            "price_to_string": "73,37:-",
            "product_extra_menus": [
              {
                "default_extra": null,
                "id": 798,
                "inserted_at": "2020-07-29T17:54:33",
                "mandatory": false,
                "name": "Sauces",
                "pick_only_one": false,
                "product_extras": [
                  {
                    "hidden": false,
                    "id": 580,
                    "inserted_at": "2020-07-29T17:54:33",
                    "new_name": "Huge Pommes",
                    "new_price": {
                      "amount": 8012,
                      "currency": "SEK"
                    },
                    "new_price_to_string": "80,12:-",
                    "product": {
                      "hidden": false,
                      "id": 5283,
                      "inserted_at": "2020-07-29T17:54:33",
                      "menu_id": null,
                      "name": "Pommes",
                      "price": {
                        "amount": 3766,
                        "currency": "SEK"
                      },
                      "price_to_string": "37,66:-",
                      "restaurant_id": 39909
                    },
                    "product_extra_menu_id": 798,
                    "product_id": 5283
                  },
                  {
                    "hidden": false,
                    "id": 579,
                    "inserted_at": "2020-07-29T17:54:33",
                    "new_name": "Big Pommes",
                    "new_price": {
                      "amount": 5306,
                      "currency": "SEK"
                    },
                    "new_price_to_string": "53,06:-",
                    "product": {
                      "hidden": false,
                      "id": 5283,
                      "inserted_at": "2020-07-29T17:54:33",
                      "menu_id": null,
                      "name": "Pommes",
                      "price": {
                        "amount": 3766,
                        "currency": "SEK"
                      },
                      "price_to_string": "37,66:-",
                      "restaurant_id": 39909
                    },
                    "product_extra_menu_id": 798,
                    "product_id": 5283
                  },
                  {
                    "hidden": false,
                    "id": 578,
                    "inserted_at": "2020-07-29T17:54:33",
                    "new_name": "Medium Pommes",
                    "new_price": {
                      "amount": 4324,
                      "currency": "SEK"
                    },
                    "new_price_to_string": "43,24:-",
                    "product": {
                      "hidden": false,
                      "id": 5283,
                      "inserted_at": "2020-07-29T17:54:33",
                      "menu_id": null,
                      "name": "Pommes",
                      "price": {
                        "amount": 3766,
                        "currency": "SEK"
                      },
                      "price_to_string": "37,66:-",
                      "restaurant_id": 39909
                    },
                    "product_extra_menu_id": 798,
                    "product_id": 5283
                  },
                  {
                    "hidden": false,
                    "id": 577,
                    "inserted_at": "2020-07-29T17:54:33",
                    "new_name": "Small Pommes",
                    "new_price": {
                      "amount": 1820,
                      "currency": "SEK"
                    },
                    "new_price_to_string": "18,20:-",
                    "product": {
                      "hidden": false,
                      "id": 5283,
                      "inserted_at": "2020-07-29T17:54:33",
                      "menu_id": null,
                      "name": "Pommes",
                      "price": {
                        "amount": 3766,
                        "currency": "SEK"
                      },
                      "price_to_string": "37,66:-",
                      "restaurant_id": 39909
                    },
                    "product_extra_menu_id": 798,
                    "product_id": 5283
                  }
                ],
                "product_id": 5279
              }
            ],
            "restaurant_id": null
          },
          {
            "hidden": false,
            "id": 5280,
            "inserted_at": "2020-07-29T17:54:33",
            "menu_id": 11607,
            "name": "16\" Cheese",
            "price": {
              "amount": 9039,
              "currency": "SEK"
            },
            "price_to_string": "90,39:-",
            "product_extra_menus": [],
            "restaurant_id": null
          },
          {
            "hidden": false,
            "id": 5281,
            "inserted_at": "2020-07-29T17:54:33",
            "menu_id": 11607,
            "name": "18\" Fajita",
            "price": {
              "amount": 7600,
              "currency": "SEK"
            },
            "price_to_string": "76:-",
            "product_extra_menus": [],
            "restaurant_id": null
          },
          {
            "hidden": false,
            "id": 5282,
            "inserted_at": "2020-07-29T17:54:33",
            "menu_id": 11607,
            "name": "30\" Deep Fried Pizza Four Seasons",
            "price": {
              "amount": 8061,
              "currency": "SEK"
            },
            "price_to_string": "80,61:-",
            "product_extra_menus": [],
            "restaurant_id": null
          }
        ],
        "restaurant_id": 39909
      }
    ],
    "name": "Nemo’s Pizza",
    "unlisted_products": [
      {
        "hidden": false,
        "id": 5283,
        "inserted_at": "2020-07-29T17:54:33",
        "menu_id": null,
        "name": "Pommes",
        "price": {
          "amount": 3766,
          "currency": "SEK"
        },
        "price_to_string": "37,66:-",
        "product_extra_menus": [],
        "restaurant_id": 39909
      }
    ],
    "url": "https://nemos-pizza.se"
  }
}
```
---
## <a id=channel-restaurants-lobby-guest-actions-get-all-menus-from-a-restaurant></a>guest actions - get all menus from a restaurant
#### → <ins>Message to server</ins>
* __Topic:__ restaurants:lobby
* __Event:__ get_menus
* __Body:__
```json
{
  "restaurant_id": 39945
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "menus": [
      {
        "id": 11615,
        "name": "Onion & Gorgonzola",
        "products": [],
        "restaurant_id": 39945
      },
      {
        "id": 11616,
        "name": "Poutine",
        "products": [],
        "restaurant_id": 39945
      },
      {
        "id": 11617,
        "name": "Hawaiian",
        "products": [],
        "restaurant_id": 39945
      },
      {
        "id": 11618,
        "name": "Mockba",
        "products": [],
        "restaurant_id": 39945
      }
    ]
  }
}
```
---
## <a id=channel-restaurants-lobby-guest-actions-get-one-menu></a>guest actions - get one menu
#### → <ins>Message to server</ins>
* __Topic:__ restaurants:lobby
* __Event:__ get_menu
* __Body:__
```json
{
  "menu_id": 11614
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "id": 11614,
    "name": "Capricciosa",
    "products": [],
    "restaurant_id": 39939
  }
}
```
---
## <a id=channel-restaurants-lobby-user-actions-create-a-restaurant></a>user actions - create a restaurant
#### → <ins>Message to server</ins>
* __Topic:__ restaurants:lobby
* __Event:__ create_restaurant
* __Body:__
```json
{
  "address": "some address",
  "name": "test",
  "url": "some url"
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "address": "some address",
    "created": "2020-07-29T17:54:34",
    "id": 39941,
    "menus": [],
    "name": "test",
    "unlisted_products": [],
    "url": "some url"
  }
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ restaurants:lobby
* __Event:__ restaurant_created
* __Body:__
```json
{
  "data": {
    "address": "some address",
    "created": "2020-07-29T17:54:34",
    "id": 39941,
    "menus": [],
    "name": "test",
    "unlisted_products": [],
    "url": "some url"
  }
}
```
---
## <a id=channel-restaurants-lobby-user-actions-update-a-restaurant></a>user actions - update a restaurant
#### → <ins>Message to server</ins>
* __Topic:__ restaurants:lobby
* __Event:__ update_restaurant
* __Body:__
```json
{
  "params": {
    "name": "new name",
    "url": "new url"
  },
  "restaurant_id": 39917
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "address": "7 Bailey Manor",
    "created": "2020-07-29T17:54:33",
    "id": 39917,
    "menus": [],
    "name": "new name",
    "unlisted_products": [],
    "url": "new url"
  }
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ restaurants:lobby
* __Event:__ restaurant_updated
* __Body:__
```json
{
  "data": {
    "address": "7 Bailey Manor",
    "created": "2020-07-29T17:54:33",
    "id": 39917,
    "menus": [],
    "name": "new name",
    "unlisted_products": [],
    "url": "new url"
  }
}
```
---
## <a id=channel-restaurants-lobby-user-actions-delete-a-restaurant></a>user actions - delete a restaurant
#### → <ins>Message to server</ins>
* __Topic:__ restaurants:lobby
* __Event:__ delete_restaurant
* __Body:__
```json
{
  "restaurant_id": 39915
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted restaurant 'The Pizza Hole' with id 39915"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ restaurants:lobby
* __Event:__ restaurant_deleted
* __Body:__
```json
{
  "message": "Deleted restaurant 'The Pizza Hole'",
  "restaurant_id": 39915
}
```
---
## <a id=channel-restaurants-lobby-user-actions-create-a-menu></a>user actions - create a menu
#### → <ins>Message to server</ins>
* __Topic:__ restaurants:lobby
* __Event:__ create_menu
* __Body:__
```json
{
  "name": "test menu",
  "restaurant_id": 39907
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "id": 11606,
    "name": "test menu",
    "products": [],
    "restaurant_id": 39907
  }
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ restaurants:lobby
* __Event:__ menu_created
* __Body:__
```json
{
  "data": {
    "id": 11606,
    "name": "test menu",
    "products": [],
    "restaurant_id": 39907
  }
}
```
---
## <a id=channel-restaurants-lobby-user-actions-update-a-menu></a>user actions - update a menu
#### → <ins>Message to server</ins>
* __Topic:__ restaurants:lobby
* __Event:__ update_menu
* __Body:__
```json
{
  "menu_id": 11605,
  "params": {
    "name": "some new name"
  }
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "id": 11605,
    "name": "some new name",
    "products": [],
    "restaurant_id": 39905
  }
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ restaurants:lobby
* __Event:__ menu_updated
* __Body:__
```json
{
  "data": {
    "id": 11605,
    "name": "some new name",
    "products": [],
    "restaurant_id": 39905
  }
}
```
---
## <a id=channel-restaurants-lobby-user-actions-delete-a-menu></a>user actions - delete a menu
#### → <ins>Message to server</ins>
* __Topic:__ restaurants:lobby
* __Event:__ delete_menu
* __Body:__
```json
{
  "menu_id": 11604
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted menu 'test menu1' with id 11604"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ restaurants:lobby
* __Event:__ menu_deleted
* __Body:__
```json
{
  "menu_id": 11604,
  "message": "Deleted menu 'test menu1'"
}
```
---
## <a id=channel-restaurants-lobby-user-actions-change-sequence-of-menu></a>user actions - change sequence of menu
#### → <ins>Message to server</ins>
* __Topic:__ restaurants:lobby
* __Event:__ get_restaurant
* __Body:__
```json
{
  "restaurant_id": 39937
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "address": "47352 Nona Estates",
    "created": "2020-07-29T17:54:34",
    "id": 39937,
    "menus": [
      {
        "id": 11610,
        "name": "BBQ Chicken",
        "products": [],
        "restaurant_id": 39937
      },
      {
        "id": 11611,
        "name": "Capricciosa",
        "products": [],
        "restaurant_id": 39937
      },
      {
        "id": 11612,
        "name": "Veggie Korma",
        "products": [],
        "restaurant_id": 39937
      },
      {
        "id": 11613,
        "name": "Capricciosa ",
        "products": [],
        "restaurant_id": 39937
      }
    ],
    "name": "Paisanos",
    "unlisted_products": [],
    "url": "https://paisanos.se"
  }
}
```
#### → <ins>Message to server</ins>
* __Topic:__ restaurants:lobby
* __Event:__ change_menu_sequence
* __Body:__
```json
{
  "action": "insert_at",
  "index": 1,
  "menu_id": 11613,
  "restaurant_id": 39937
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "menus": [
      {
        "id": 11610,
        "name": "BBQ Chicken",
        "products": [],
        "restaurant_id": 39937
      },
      {
        "id": 11613,
        "name": "Capricciosa ",
        "products": [],
        "restaurant_id": 39937
      },
      {
        "id": 11611,
        "name": "Capricciosa",
        "products": [],
        "restaurant_id": 39937
      },
      {
        "id": 11612,
        "name": "Veggie Korma",
        "products": [],
        "restaurant_id": 39937
      }
    ]
  }
}
```
#### → <ins>Message to server</ins>
* __Topic:__ restaurants:lobby
* __Event:__ change_menu_sequence
* __Body:__
```json
{
  "action": "higher",
  "menu_id": 11612,
  "restaurant_id": 39937
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "menus": [
      {
        "id": 11610,
        "name": "BBQ Chicken",
        "products": [],
        "restaurant_id": 39937
      },
      {
        "id": 11613,
        "name": "Capricciosa ",
        "products": [],
        "restaurant_id": 39937
      },
      {
        "id": 11612,
        "name": "Veggie Korma",
        "products": [],
        "restaurant_id": 39937
      },
      {
        "id": 11611,
        "name": "Capricciosa",
        "products": [],
        "restaurant_id": 39937
      }
    ]
  }
}
```
#### → <ins>Message to server</ins>
* __Topic:__ restaurants:lobby
* __Event:__ change_menu_sequence
* __Body:__
```json
{
  "action": "lower",
  "menu_id": 11610,
  "restaurant_id": 39937
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "menus": [
      {
        "id": 11613,
        "name": "Capricciosa ",
        "products": [],
        "restaurant_id": 39937
      },
      {
        "id": 11610,
        "name": "BBQ Chicken",
        "products": [],
        "restaurant_id": 39937
      },
      {
        "id": 11612,
        "name": "Veggie Korma",
        "products": [],
        "restaurant_id": 39937
      },
      {
        "id": 11611,
        "name": "Capricciosa",
        "products": [],
        "restaurant_id": 39937
      }
    ]
  }
}
```
#### → <ins>Message to server</ins>
* __Topic:__ restaurants:lobby
* __Event:__ change_menu_sequence
* __Body:__
```json
{
  "action": "to_top",
  "menu_id": 11612,
  "restaurant_id": 39937
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "menus": [
      {
        "id": 11612,
        "name": "Veggie Korma",
        "products": [],
        "restaurant_id": 39937
      },
      {
        "id": 11613,
        "name": "Capricciosa ",
        "products": [],
        "restaurant_id": 39937
      },
      {
        "id": 11610,
        "name": "BBQ Chicken",
        "products": [],
        "restaurant_id": 39937
      },
      {
        "id": 11611,
        "name": "Capricciosa",
        "products": [],
        "restaurant_id": 39937
      }
    ]
  }
}
```
#### → <ins>Message to server</ins>
* __Topic:__ restaurants:lobby
* __Event:__ change_menu_sequence
* __Body:__
```json
{
  "action": "to_bottom",
  "menu_id": 11613,
  "restaurant_id": 39937
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "menus": [
      {
        "id": 11612,
        "name": "Veggie Korma",
        "products": [],
        "restaurant_id": 39937
      },
      {
        "id": 11610,
        "name": "BBQ Chicken",
        "products": [],
        "restaurant_id": 39937
      },
      {
        "id": 11611,
        "name": "Capricciosa",
        "products": [],
        "restaurant_id": 39937
      },
      {
        "id": 11613,
        "name": "Capricciosa ",
        "products": [],
        "restaurant_id": 39937
      }
    ]
  }
}
```
---
# <a id=channel-merchandise-lobby></a>channel merchandise:lobby
## <a id=channel-merchandise-lobby-test-actions-ping></a>test actions - ping
#### → <ins>Message to server</ins>
* __Topic:__ merchandise:lobby
* __Event:__ ping
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "pong"
}
```
---
## <a id=channel-merchandise-lobby-test-actions-ensure-logged-in-correctly></a>test actions - ensure logged in correctly
#### → <ins>Message to server</ins>
* __Topic:__ merchandise:lobby
* __Event:__ logged_in
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "user_id": 50115
}
```
---
## <a id=channel-merchandise-lobby-guest-actions-get-products-from-menu></a>guest actions - get products from menu
#### → <ins>Message to server</ins>
* __Topic:__ merchandise:lobby
* __Event:__ get_products
* __Body:__
```json
{
  "menu_id": 11590
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "products": [
      {
        "hidden": false,
        "id": 5258,
        "inserted_at": "2020-07-29T17:54:32",
        "menu_id": 11590,
        "name": "Small with Alfredo Sauce, Hamburger, Caramelised Onions, Bacon, and Buffalo Sauce",
        "price": {
          "amount": 7043,
          "currency": "SEK"
        },
        "price_to_string": "70,43:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5259,
        "inserted_at": "2020-07-29T17:54:32",
        "menu_id": 11590,
        "name": "Family Flatbread Onion & Gorgonzola",
        "price": {
          "amount": 8722,
          "currency": "SEK"
        },
        "price_to_string": "87,22:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5260,
        "inserted_at": "2020-07-29T17:54:32",
        "menu_id": 11590,
        "name": "18\" Neapolitan with Shellfish and Hot Dogs",
        "price": {
          "amount": 9822,
          "currency": "SEK"
        },
        "price_to_string": "98,22:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5261,
        "inserted_at": "2020-07-29T17:54:32",
        "menu_id": 11590,
        "name": "Personal Smoked Salmon & Goat Cheese",
        "price": {
          "amount": 7772,
          "currency": "SEK"
        },
        "price_to_string": "77,72:-",
        "product_extra_menus": [],
        "restaurant_id": null
      }
    ]
  }
}
```
---
## <a id=channel-merchandise-lobby-user-actions-create-a-product></a>user actions - create a product
#### → <ins>Message to server</ins>
* __Topic:__ merchandise:lobby
* __Event:__ create_product
* __Body:__
```json
{
  "menu_id": 11602,
  "name": "test product 99",
  "price": 9900
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "hidden": false,
    "id": 5274,
    "inserted_at": "2020-07-29T17:54:32",
    "menu_id": 11602,
    "name": "test product 99",
    "price": {
      "amount": 9900,
      "currency": "SEK"
    },
    "price_to_string": "99:-",
    "product_extra_menus": [],
    "restaurant_id": null
  }
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ merchandise:lobby
* __Event:__ product_created
* __Body:__
```json
{
  "data": {
    "hidden": false,
    "id": 5274,
    "inserted_at": "2020-07-29T17:54:32",
    "menu_id": 11602,
    "name": "test product 99",
    "price": {
      "amount": 9900,
      "currency": "SEK"
    },
    "price_to_string": "99:-",
    "product_extra_menus": [],
    "restaurant_id": null
  }
}
```
---
## <a id=channel-merchandise-lobby-user-actions-create-a-unlisted-product></a>user actions - create a unlisted product
#### → <ins>Message to server</ins>
* __Topic:__ merchandise:lobby
* __Event:__ create_unlisted_product
* __Body:__
```json
{
  "hidden": true,
  "name": "test product 29",
  "price": 2900,
  "restaurant_id": 39888
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "hidden": true,
    "id": 5267,
    "inserted_at": "2020-07-29T17:54:32",
    "menu_id": null,
    "name": "test product 29",
    "price": {
      "amount": 2900,
      "currency": "SEK"
    },
    "price_to_string": "29:-",
    "product_extra_menus": [],
    "restaurant_id": 39888
  }
}
```
---
## <a id=channel-merchandise-lobby-user-actions-update-a-product></a>user actions - update a product
#### → <ins>Message to server</ins>
* __Topic:__ merchandise:lobby
* __Event:__ update_product
* __Body:__
```json
{
  "params": {
    "name": "new product name",
    "price": 133700
  },
  "product_id": 5265
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "hidden": false,
    "id": 5265,
    "inserted_at": "2020-07-29T17:54:32",
    "menu_id": 11595,
    "name": "new product name",
    "price": {
      "amount": 133700,
      "currency": "SEK"
    },
    "price_to_string": "1.337:-",
    "product_extra_menus": [],
    "restaurant_id": null
  }
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ merchandise:lobby
* __Event:__ product_updated
* __Body:__
```json
{
  "data": {
    "hidden": false,
    "id": 5265,
    "inserted_at": "2020-07-29T17:54:32",
    "menu_id": 11595,
    "name": "new product name",
    "price": {
      "amount": 133700,
      "currency": "SEK"
    },
    "price_to_string": "1.337:-",
    "product_extra_menus": [],
    "restaurant_id": null
  }
}
```
---
## <a id=channel-merchandise-lobby-user-actions-delete-a-product></a>user actions - delete a product
#### → <ins>Message to server</ins>
* __Topic:__ merchandise:lobby
* __Event:__ delete_product
* __Body:__
```json
{
  "product_id": 5264
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted product 'Large Vegetariana' with id 5264"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ merchandise:lobby
* __Event:__ product_deleted
* __Body:__
```json
{
  "message": "Deleted product 'Large Vegetariana'",
  "product_id": 5264
}
```
---
## <a id=channel-merchandise-lobby-user-actions-change-sequence-of-product></a>user actions - change sequence of product
#### → <ins>Message to server</ins>
* __Topic:__ merchandise:lobby
* __Event:__ get_products
* __Body:__
```json
{
  "menu_id": 11603
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "products": [
      {
        "hidden": false,
        "id": 5275,
        "inserted_at": "2020-07-29T17:54:32",
        "menu_id": 11603,
        "name": "Small Tomato Pie with Zucchini, Duck, Anchovies, Gravy, and Mutton",
        "price": {
          "amount": 8342,
          "currency": "SEK"
        },
        "price_to_string": "83,42:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5276,
        "inserted_at": "2020-07-29T17:54:32",
        "menu_id": 11603,
        "name": "Family Thick Crust with Garlic",
        "price": {
          "amount": 9844,
          "currency": "SEK"
        },
        "price_to_string": "98,44:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5277,
        "inserted_at": "2020-07-29T17:54:32",
        "menu_id": 11603,
        "name": "9\" Detroit-style with Butter Chicken Sauce and Eel",
        "price": {
          "amount": 7251,
          "currency": "SEK"
        },
        "price_to_string": "72,51:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5278,
        "inserted_at": "2020-07-29T17:54:32",
        "menu_id": 11603,
        "name": "Medium Smoked Salmon & Goat Cheese",
        "price": {
          "amount": 7645,
          "currency": "SEK"
        },
        "price_to_string": "76,45:-",
        "product_extra_menus": [],
        "restaurant_id": null
      }
    ]
  }
}
```
#### → <ins>Message to server</ins>
* __Topic:__ merchandise:lobby
* __Event:__ change_product_sequence
* __Body:__
```json
{
  "action": "insert_at",
  "index": 1,
  "menu_id": 11603,
  "product_id": 5278
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "products": [
      {
        "hidden": false,
        "id": 5275,
        "inserted_at": "2020-07-29T17:54:32",
        "menu_id": 11603,
        "name": "Small Tomato Pie with Zucchini, Duck, Anchovies, Gravy, and Mutton",
        "price": {
          "amount": 8342,
          "currency": "SEK"
        },
        "price_to_string": "83,42:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5278,
        "inserted_at": "2020-07-29T17:54:32",
        "menu_id": 11603,
        "name": "Medium Smoked Salmon & Goat Cheese",
        "price": {
          "amount": 7645,
          "currency": "SEK"
        },
        "price_to_string": "76,45:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5276,
        "inserted_at": "2020-07-29T17:54:32",
        "menu_id": 11603,
        "name": "Family Thick Crust with Garlic",
        "price": {
          "amount": 9844,
          "currency": "SEK"
        },
        "price_to_string": "98,44:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5277,
        "inserted_at": "2020-07-29T17:54:32",
        "menu_id": 11603,
        "name": "9\" Detroit-style with Butter Chicken Sauce and Eel",
        "price": {
          "amount": 7251,
          "currency": "SEK"
        },
        "price_to_string": "72,51:-",
        "product_extra_menus": [],
        "restaurant_id": null
      }
    ]
  }
}
```
#### → <ins>Message to server</ins>
* __Topic:__ merchandise:lobby
* __Event:__ change_product_sequence
* __Body:__
```json
{
  "action": "higher",
  "menu_id": 11603,
  "product_id": 5277
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "products": [
      {
        "hidden": false,
        "id": 5275,
        "inserted_at": "2020-07-29T17:54:32",
        "menu_id": 11603,
        "name": "Small Tomato Pie with Zucchini, Duck, Anchovies, Gravy, and Mutton",
        "price": {
          "amount": 8342,
          "currency": "SEK"
        },
        "price_to_string": "83,42:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5278,
        "inserted_at": "2020-07-29T17:54:32",
        "menu_id": 11603,
        "name": "Medium Smoked Salmon & Goat Cheese",
        "price": {
          "amount": 7645,
          "currency": "SEK"
        },
        "price_to_string": "76,45:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5277,
        "inserted_at": "2020-07-29T17:54:32",
        "menu_id": 11603,
        "name": "9\" Detroit-style with Butter Chicken Sauce and Eel",
        "price": {
          "amount": 7251,
          "currency": "SEK"
        },
        "price_to_string": "72,51:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5276,
        "inserted_at": "2020-07-29T17:54:32",
        "menu_id": 11603,
        "name": "Family Thick Crust with Garlic",
        "price": {
          "amount": 9844,
          "currency": "SEK"
        },
        "price_to_string": "98,44:-",
        "product_extra_menus": [],
        "restaurant_id": null
      }
    ]
  }
}
```
#### → <ins>Message to server</ins>
* __Topic:__ merchandise:lobby
* __Event:__ change_product_sequence
* __Body:__
```json
{
  "action": "lower",
  "menu_id": 11603,
  "product_id": 5275
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "products": [
      {
        "hidden": false,
        "id": 5278,
        "inserted_at": "2020-07-29T17:54:32",
        "menu_id": 11603,
        "name": "Medium Smoked Salmon & Goat Cheese",
        "price": {
          "amount": 7645,
          "currency": "SEK"
        },
        "price_to_string": "76,45:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5275,
        "inserted_at": "2020-07-29T17:54:32",
        "menu_id": 11603,
        "name": "Small Tomato Pie with Zucchini, Duck, Anchovies, Gravy, and Mutton",
        "price": {
          "amount": 8342,
          "currency": "SEK"
        },
        "price_to_string": "83,42:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5277,
        "inserted_at": "2020-07-29T17:54:32",
        "menu_id": 11603,
        "name": "9\" Detroit-style with Butter Chicken Sauce and Eel",
        "price": {
          "amount": 7251,
          "currency": "SEK"
        },
        "price_to_string": "72,51:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5276,
        "inserted_at": "2020-07-29T17:54:32",
        "menu_id": 11603,
        "name": "Family Thick Crust with Garlic",
        "price": {
          "amount": 9844,
          "currency": "SEK"
        },
        "price_to_string": "98,44:-",
        "product_extra_menus": [],
        "restaurant_id": null
      }
    ]
  }
}
```
#### → <ins>Message to server</ins>
* __Topic:__ merchandise:lobby
* __Event:__ change_product_sequence
* __Body:__
```json
{
  "action": "to_top",
  "menu_id": 11603,
  "product_id": 5277
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "products": [
      {
        "hidden": false,
        "id": 5277,
        "inserted_at": "2020-07-29T17:54:32",
        "menu_id": 11603,
        "name": "9\" Detroit-style with Butter Chicken Sauce and Eel",
        "price": {
          "amount": 7251,
          "currency": "SEK"
        },
        "price_to_string": "72,51:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5278,
        "inserted_at": "2020-07-29T17:54:32",
        "menu_id": 11603,
        "name": "Medium Smoked Salmon & Goat Cheese",
        "price": {
          "amount": 7645,
          "currency": "SEK"
        },
        "price_to_string": "76,45:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5275,
        "inserted_at": "2020-07-29T17:54:32",
        "menu_id": 11603,
        "name": "Small Tomato Pie with Zucchini, Duck, Anchovies, Gravy, and Mutton",
        "price": {
          "amount": 8342,
          "currency": "SEK"
        },
        "price_to_string": "83,42:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5276,
        "inserted_at": "2020-07-29T17:54:32",
        "menu_id": 11603,
        "name": "Family Thick Crust with Garlic",
        "price": {
          "amount": 9844,
          "currency": "SEK"
        },
        "price_to_string": "98,44:-",
        "product_extra_menus": [],
        "restaurant_id": null
      }
    ]
  }
}
```
#### → <ins>Message to server</ins>
* __Topic:__ merchandise:lobby
* __Event:__ change_product_sequence
* __Body:__
```json
{
  "action": "to_bottom",
  "menu_id": 11603,
  "product_id": 5278
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "products": [
      {
        "hidden": false,
        "id": 5277,
        "inserted_at": "2020-07-29T17:54:32",
        "menu_id": 11603,
        "name": "9\" Detroit-style with Butter Chicken Sauce and Eel",
        "price": {
          "amount": 7251,
          "currency": "SEK"
        },
        "price_to_string": "72,51:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5275,
        "inserted_at": "2020-07-29T17:54:32",
        "menu_id": 11603,
        "name": "Small Tomato Pie with Zucchini, Duck, Anchovies, Gravy, and Mutton",
        "price": {
          "amount": 8342,
          "currency": "SEK"
        },
        "price_to_string": "83,42:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5276,
        "inserted_at": "2020-07-29T17:54:32",
        "menu_id": 11603,
        "name": "Family Thick Crust with Garlic",
        "price": {
          "amount": 9844,
          "currency": "SEK"
        },
        "price_to_string": "98,44:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5278,
        "inserted_at": "2020-07-29T17:54:32",
        "menu_id": 11603,
        "name": "Medium Smoked Salmon & Goat Cheese",
        "price": {
          "amount": 7645,
          "currency": "SEK"
        },
        "price_to_string": "76,45:-",
        "product_extra_menus": [],
        "restaurant_id": null
      }
    ]
  }
}
```
---
## <a id=channel-merchandise-lobby-user-actions-create-a-product-extra-menu></a>user actions - create a product extra menu
#### → <ins>Message to server</ins>
* __Topic:__ merchandise:lobby
* __Event:__ create_product_extra_menu
* __Body:__
```json
{
  "name": "Sauces",
  "product_id": 5263
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "default_extra": null,
    "id": 794,
    "inserted_at": "2020-07-29T17:54:32",
    "mandatory": false,
    "name": "Sauces",
    "pick_only_one": false,
    "product_extras": [],
    "product_id": 5263
  }
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ merchandise:lobby
* __Event:__ product_extra_menu_created
* __Body:__
```json
{
  "data": {
    "default_extra": null,
    "id": 794,
    "inserted_at": "2020-07-29T17:54:32",
    "mandatory": false,
    "name": "Sauces",
    "pick_only_one": false,
    "product_extras": [],
    "product_id": 5263
  }
}
```
---
## <a id=channel-merchandise-lobby-user-actions-update-a-product-extra-menu></a>user actions - update a product extra menu
#### → <ins>Message to server</ins>
* __Topic:__ merchandise:lobby
* __Event:__ update_product_extra_menu
* __Body:__
```json
{
  "params": {
    "mandatory": true,
    "name": "Must Pick One Sauce",
    "pick_only_one": true
  },
  "product_extra_menu_id": 793
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "default_extra": null,
    "id": 793,
    "inserted_at": "2020-07-29T17:54:32",
    "mandatory": true,
    "name": "Must Pick One Sauce",
    "pick_only_one": true,
    "product_extras": [],
    "product_id": 5262
  }
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ merchandise:lobby
* __Event:__ product_extra_menu_updated
* __Body:__
```json
{
  "data": {
    "default_extra": null,
    "id": 793,
    "inserted_at": "2020-07-29T17:54:32",
    "mandatory": true,
    "name": "Must Pick One Sauce",
    "pick_only_one": true,
    "product_extras": [],
    "product_id": 5262
  }
}
```
---
## <a id=channel-merchandise-lobby-user-actions-delete-a-product-extra-menu></a>user actions - delete a product extra menu
#### → <ins>Message to server</ins>
* __Topic:__ merchandise:lobby
* __Event:__ delete_product_extra_menu
* __Body:__
```json
{
  "product_extra_menu_id": 797
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted product extra menu: 'Sauces' with id 797"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ merchandise:lobby
* __Event:__ product_extra_menu_deleted
* __Body:__
```json
{
  "message": "Deleted product extra menu: 'Sauces'",
  "product_extra_menu_id": 797
}
```
---
## <a id=channel-merchandise-lobby-user-actions-create-a-product-extra></a>user actions - create a product extra
#### → <ins>Message to server</ins>
* __Topic:__ merchandise:lobby
* __Event:__ create_product_extra
* __Body:__
```json
{
  "new_name": "Gravy",
  "new_price": 1000,
  "product_extra_menu_id": 796,
  "product_id": 5271
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "hidden": false,
    "id": 576,
    "inserted_at": "2020-07-29T17:54:32",
    "new_name": "Gravy",
    "new_price": {
      "amount": 1000,
      "currency": "SEK"
    },
    "new_price_to_string": "10:-",
    "product": {
      "hidden": false,
      "id": 5271,
      "inserted_at": "2020-07-29T17:54:32",
      "menu_id": null,
      "name": "Gravy",
      "price": {
        "amount": 4364,
        "currency": "SEK"
      },
      "price_to_string": "43,64:-",
      "restaurant_id": 39891
    },
    "product_extra_menu_id": 796,
    "product_id": 5271
  }
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ merchandise:lobby
* __Event:__ product_extra_created
* __Body:__
```json
{
  "data": {
    "hidden": false,
    "id": 576,
    "inserted_at": "2020-07-29T17:54:32",
    "new_name": "Gravy",
    "new_price": {
      "amount": 1000,
      "currency": "SEK"
    },
    "new_price_to_string": "10:-",
    "product": {
      "hidden": false,
      "id": 5271,
      "inserted_at": "2020-07-29T17:54:32",
      "menu_id": null,
      "name": "Gravy",
      "price": {
        "amount": 4364,
        "currency": "SEK"
      },
      "price_to_string": "43,64:-",
      "restaurant_id": 39891
    },
    "product_extra_menu_id": 796,
    "product_id": 5271
  }
}
```
---
## <a id=channel-merchandise-lobby-user-actions-update-a-product-extra></a>user actions - update a product extra
#### → <ins>Message to server</ins>
* __Topic:__ merchandise:lobby
* __Event:__ update_product_extra
* __Body:__
```json
{
  "params": {
    "new_name": "Sauce X"
  },
  "product_extra_id": 575
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "hidden": false,
    "id": 575,
    "inserted_at": "2020-07-29T17:54:32",
    "new_name": "Sauce X",
    "new_price": {
      "amount": 900,
      "currency": "SEK"
    },
    "new_price_to_string": "9:-",
    "product": {
      "hidden": false,
      "id": 5269,
      "inserted_at": "2020-07-29T17:54:32",
      "menu_id": null,
      "name": "Mustard",
      "price": {
        "amount": 4079,
        "currency": "SEK"
      },
      "price_to_string": "40,79:-",
      "restaurant_id": 39889
    },
    "product_extra_menu_id": 795,
    "product_id": 5269
  }
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ merchandise:lobby
* __Event:__ product_extra_updated
* __Body:__
```json
{
  "data": {
    "hidden": false,
    "id": 575,
    "inserted_at": "2020-07-29T17:54:32",
    "new_name": "Sauce X",
    "new_price": {
      "amount": 900,
      "currency": "SEK"
    },
    "new_price_to_string": "9:-",
    "product": {
      "hidden": false,
      "id": 5269,
      "inserted_at": "2020-07-29T17:54:32",
      "menu_id": null,
      "name": "Mustard",
      "price": {
        "amount": 4079,
        "currency": "SEK"
      },
      "price_to_string": "40,79:-",
      "restaurant_id": 39889
    },
    "product_extra_menu_id": 795,
    "product_id": 5269
  }
}
```
---
## <a id=channel-merchandise-lobby-user-actions-delete-a-product-extra></a>user actions - delete a product extra
#### → <ins>Message to server</ins>
* __Topic:__ merchandise:lobby
* __Event:__ delete_product_extra
* __Body:__
```json
{
  "product_extra_id": 574
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted product extra: 'Sauce Y' with id 574"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ merchandise:lobby
* __Event:__ product_extra_deleted
* __Body:__
```json
{
  "message": "Deleted product extra: 'Sauce Y'",
  "product_extra_id": 574
}
```
---
