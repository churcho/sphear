# Channel Authentication

Websocket URL: [wss://matx.se/socket/websocket](wss://matx.se/socket/websocket)

In this API spec, each endpoint is a channel and each channel might need authentication (token parameter), but some endpoints will have guest functionality though.

When subscribing to a endpoint, connect and subscribe to the topic "lobby" with or without a token.

#### Expected input if logging in with token
```json
{
  "token": "3X4MpLeT0k3n1337"
}
```
The endpoint will reply with either:
#### Subscribed to the lobby without a token
```json
{
  "guest_success": true,
  "user_id": null
}
```
## or 
#### Subscribed and authenticated to the lobby successfully
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
  "email": "user-576460752303421501@example.com",
  "password": "hello world!"
}
```

##### ← <ins>Response to you</ins>
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FiqtoOBBI0BXM8wAAAfj
```
* __Response body:__
```json
{
  "success": {
    "token": "qT63rdI1XOABiMyXLqyLGSUWDW8e6ZWykBXnSrgxEQ4="
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
  "email": "user-576460752303421437@example.com",
  "password": "lol"
}
```

##### ← <ins>Response to you</ins>
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FiqtoOIaKQDLq0EAAAgB
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
  "email": "user-576460752303421533@example.com",
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
x-request-id: FiqtoOBBI0AtlNkAAAsi
```
* __Response body:__
```json
{
  "success": {
    "email": "user-576460752303421533@example.com",
    "token": "bM82UXuAmHhDz+45YIwnxv5y93TFd4cYvMqt3+gnaA0="
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
x-request-id: FiqtoOIaKQCM4gwAAACH
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
  "user_id": 55048
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
        "address": "2822 Mante Inlet",
        "created": "2020-08-13T00:52:07",
        "hidden": false,
        "id": 45865,
        "menus": [],
        "name": "Maria’s Pasta and Pizza",
        "unlisted_products": [],
        "url": "https://marias-pasta-and-pizza.se"
      },
      {
        "address": "075 Greenfelder Cliff",
        "created": "2020-08-13T00:52:07",
        "hidden": false,
        "id": 45866,
        "menus": [],
        "name": "CosaNostra Pizza",
        "unlisted_products": [],
        "url": "https://cosanostra-pizza.se"
      },
      {
        "address": "3 Virgie Circles",
        "created": "2020-08-13T00:52:07",
        "hidden": false,
        "id": 45867,
        "menus": [],
        "name": "Pizza on a Stick",
        "unlisted_products": [],
        "url": "https://pizza-on-a-stick.se"
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
  "restaurant_id": 45874
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "address": "98 Vicente Drive",
    "created": "2020-08-13T00:52:07",
    "hidden": false,
    "id": 45874,
    "menus": [
      {
        "hidden": false,
        "id": 14675,
        "name": "Meat Feast",
        "product_extra_menus": [],
        "products": [
          {
            "hidden": true,
            "id": 7947,
            "inserted_at": "2020-08-13T00:52:07",
            "menu_id": 14675,
            "name": "9\" Maltija",
            "price": {
              "amount": 8154,
              "currency": "SEK"
            },
            "price_to_string": "81,54:-",
            "product_extra_menus": [
              {
                "default_extra": null,
                "hidden": false,
                "id": 1686,
                "inserted_at": "2020-08-13T00:52:07",
                "mandatory": false,
                "name": "Extras",
                "pick_only_one": false,
                "product_extras": [
                  {
                    "hidden": false,
                    "id": 1197,
                    "inserted_at": "2020-08-13T00:52:07",
                    "new_name": "Huge Pommes",
                    "new_price": {
                      "amount": 6002,
                      "currency": "SEK"
                    },
                    "new_price_to_string": "60,02:-",
                    "product": {
                      "hidden": false,
                      "id": 7951,
                      "inserted_at": "2020-08-13T00:52:07",
                      "menu_id": null,
                      "name": "Pommes",
                      "price": {
                        "amount": 3489,
                        "currency": "SEK"
                      },
                      "price_to_string": "34,89:-",
                      "restaurant_id": 45874
                    },
                    "product_extra_menu_id": 1686,
                    "product_id": 7951
                  },
                  {
                    "hidden": false,
                    "id": 1196,
                    "inserted_at": "2020-08-13T00:52:07",
                    "new_name": "Big Pommes",
                    "new_price": {
                      "amount": 5177,
                      "currency": "SEK"
                    },
                    "new_price_to_string": "51,77:-",
                    "product": {
                      "hidden": false,
                      "id": 7951,
                      "inserted_at": "2020-08-13T00:52:07",
                      "menu_id": null,
                      "name": "Pommes",
                      "price": {
                        "amount": 3489,
                        "currency": "SEK"
                      },
                      "price_to_string": "34,89:-",
                      "restaurant_id": 45874
                    },
                    "product_extra_menu_id": 1686,
                    "product_id": 7951
                  },
                  {
                    "hidden": false,
                    "id": 1195,
                    "inserted_at": "2020-08-13T00:52:07",
                    "new_name": "Medium Pommes",
                    "new_price": {
                      "amount": 4594,
                      "currency": "SEK"
                    },
                    "new_price_to_string": "45,94:-",
                    "product": {
                      "hidden": false,
                      "id": 7951,
                      "inserted_at": "2020-08-13T00:52:07",
                      "menu_id": null,
                      "name": "Pommes",
                      "price": {
                        "amount": 3489,
                        "currency": "SEK"
                      },
                      "price_to_string": "34,89:-",
                      "restaurant_id": 45874
                    },
                    "product_extra_menu_id": 1686,
                    "product_id": 7951
                  },
                  {
                    "hidden": false,
                    "id": 1194,
                    "inserted_at": "2020-08-13T00:52:07",
                    "new_name": "Small Pommes",
                    "new_price": {
                      "amount": 1999,
                      "currency": "SEK"
                    },
                    "new_price_to_string": "19,99:-",
                    "product": {
                      "hidden": false,
                      "id": 7951,
                      "inserted_at": "2020-08-13T00:52:07",
                      "menu_id": null,
                      "name": "Pommes",
                      "price": {
                        "amount": 3489,
                        "currency": "SEK"
                      },
                      "price_to_string": "34,89:-",
                      "restaurant_id": 45874
                    },
                    "product_extra_menu_id": 1686,
                    "product_id": 7951
                  }
                ],
                "product_id": 7947
              }
            ],
            "restaurant_id": null
          },
          {
            "hidden": true,
            "id": 7948,
            "inserted_at": "2020-08-13T00:52:07",
            "menu_id": 14675,
            "name": "Personal with Anchovies, Zaatar, and Peperoncini",
            "price": {
              "amount": 9023,
              "currency": "SEK"
            },
            "price_to_string": "90,23:-",
            "product_extra_menus": [],
            "restaurant_id": null
          },
          {
            "hidden": true,
            "id": 7949,
            "inserted_at": "2020-08-13T00:52:07",
            "menu_id": 14675,
            "name": "Extra-Large Fig and Goat Cheese",
            "price": {
              "amount": 9987,
              "currency": "SEK"
            },
            "price_to_string": "99,87:-",
            "product_extra_menus": [],
            "restaurant_id": null
          },
          {
            "hidden": true,
            "id": 7950,
            "inserted_at": "2020-08-13T00:52:07",
            "menu_id": 14675,
            "name": "Family Breakfast",
            "price": {
              "amount": 9228,
              "currency": "SEK"
            },
            "price_to_string": "92,28:-",
            "product_extra_menus": [],
            "restaurant_id": null
          }
        ],
        "restaurant_id": 45874
      }
    ],
    "name": "Paisanos",
    "unlisted_products": [
      {
        "hidden": false,
        "id": 7951,
        "inserted_at": "2020-08-13T00:52:07",
        "menu_id": null,
        "name": "Pommes",
        "price": {
          "amount": 3489,
          "currency": "SEK"
        },
        "price_to_string": "34,89:-",
        "product_extra_menus": [],
        "restaurant_id": 45874
      }
    ],
    "url": "https://paisanos.se"
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
  "restaurant_id": 45885
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
        "hidden": false,
        "id": 14677,
        "name": "Greek",
        "product_extra_menus": [],
        "products": [],
        "restaurant_id": 45885
      },
      {
        "hidden": false,
        "id": 14678,
        "name": "Caprese",
        "product_extra_menus": [],
        "products": [],
        "restaurant_id": 45885
      },
      {
        "hidden": false,
        "id": 14679,
        "name": "Meat Feast",
        "product_extra_menus": [],
        "products": [],
        "restaurant_id": 45885
      },
      {
        "hidden": false,
        "id": 14680,
        "name": "Mockba",
        "product_extra_menus": [],
        "products": [],
        "restaurant_id": 45885
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
  "menu_id": 14682
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "hidden": false,
    "id": 14682,
    "name": "Quattro Formaggi",
    "product_extra_menus": [],
    "products": [],
    "restaurant_id": 45891
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
  "hidden": false,
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
    "created": "2020-08-13T00:52:06",
    "hidden": false,
    "id": 45851,
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
    "created": "2020-08-13T00:52:06",
    "hidden": false,
    "id": 45851,
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
  "restaurant_id": 45887
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "address": "4834 Stokes Mall",
    "created": "2020-08-13T00:52:07",
    "hidden": false,
    "id": 45887,
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
    "address": "4834 Stokes Mall",
    "created": "2020-08-13T00:52:07",
    "hidden": false,
    "id": 45887,
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
  "restaurant_id": 45872
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted restaurant 'Pizza Planet' with id 45872"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ restaurants:lobby
* __Event:__ restaurant_deleted
* __Body:__
```json
{
  "message": "Deleted restaurant 'Pizza Planet'",
  "restaurant_id": 45872
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
  "hidden": false,
  "name": "test menu",
  "restaurant_id": 45883
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "hidden": false,
    "id": 14676,
    "name": "test menu",
    "product_extra_menus": [],
    "products": [],
    "restaurant_id": 45883
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
    "hidden": false,
    "id": 14676,
    "name": "test menu",
    "product_extra_menus": [],
    "products": [],
    "restaurant_id": 45883
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
  "hidden": false,
  "menu_id": 14668,
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
    "hidden": true,
    "id": 14668,
    "name": "some new name",
    "product_extra_menus": [],
    "products": [],
    "restaurant_id": 45847
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
    "hidden": true,
    "id": 14668,
    "name": "some new name",
    "product_extra_menus": [],
    "products": [],
    "restaurant_id": 45847
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
  "menu_id": 14681
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted menu 'test menu1' with id 14681"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ restaurants:lobby
* __Event:__ menu_deleted
* __Body:__
```json
{
  "menu_id": 14681,
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
  "restaurant_id": 45856
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "address": "5 Jacobi Spring",
    "created": "2020-08-13T00:52:06",
    "hidden": false,
    "id": 45856,
    "menus": [
      {
        "hidden": false,
        "id": 14670,
        "name": "Romana",
        "product_extra_menus": [],
        "products": [],
        "restaurant_id": 45856
      },
      {
        "hidden": false,
        "id": 14671,
        "name": "Maltija",
        "product_extra_menus": [],
        "products": [],
        "restaurant_id": 45856
      },
      {
        "hidden": false,
        "id": 14672,
        "name": "Bolognese",
        "product_extra_menus": [],
        "products": [],
        "restaurant_id": 45856
      },
      {
        "hidden": false,
        "id": 14673,
        "name": "Chicken Pesto",
        "product_extra_menus": [],
        "products": [],
        "restaurant_id": 45856
      }
    ],
    "name": "The Pizza Hole",
    "unlisted_products": [],
    "url": "https://the-pizza-hole.se"
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
  "menu_id": 14673,
  "restaurant_id": 45856
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
        "hidden": false,
        "id": 14670,
        "name": "Romana",
        "product_extra_menus": [],
        "products": [],
        "restaurant_id": 45856
      },
      {
        "hidden": false,
        "id": 14673,
        "name": "Chicken Pesto",
        "product_extra_menus": [],
        "products": [],
        "restaurant_id": 45856
      },
      {
        "hidden": false,
        "id": 14671,
        "name": "Maltija",
        "product_extra_menus": [],
        "products": [],
        "restaurant_id": 45856
      },
      {
        "hidden": false,
        "id": 14672,
        "name": "Bolognese",
        "product_extra_menus": [],
        "products": [],
        "restaurant_id": 45856
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
  "menu_id": 14672,
  "restaurant_id": 45856
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
        "hidden": false,
        "id": 14670,
        "name": "Romana",
        "product_extra_menus": [],
        "products": [],
        "restaurant_id": 45856
      },
      {
        "hidden": false,
        "id": 14673,
        "name": "Chicken Pesto",
        "product_extra_menus": [],
        "products": [],
        "restaurant_id": 45856
      },
      {
        "hidden": false,
        "id": 14672,
        "name": "Bolognese",
        "product_extra_menus": [],
        "products": [],
        "restaurant_id": 45856
      },
      {
        "hidden": false,
        "id": 14671,
        "name": "Maltija",
        "product_extra_menus": [],
        "products": [],
        "restaurant_id": 45856
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
  "menu_id": 14670,
  "restaurant_id": 45856
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
        "hidden": false,
        "id": 14673,
        "name": "Chicken Pesto",
        "product_extra_menus": [],
        "products": [],
        "restaurant_id": 45856
      },
      {
        "hidden": false,
        "id": 14670,
        "name": "Romana",
        "product_extra_menus": [],
        "products": [],
        "restaurant_id": 45856
      },
      {
        "hidden": false,
        "id": 14672,
        "name": "Bolognese",
        "product_extra_menus": [],
        "products": [],
        "restaurant_id": 45856
      },
      {
        "hidden": false,
        "id": 14671,
        "name": "Maltija",
        "product_extra_menus": [],
        "products": [],
        "restaurant_id": 45856
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
  "menu_id": 14672,
  "restaurant_id": 45856
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
        "hidden": false,
        "id": 14672,
        "name": "Bolognese",
        "product_extra_menus": [],
        "products": [],
        "restaurant_id": 45856
      },
      {
        "hidden": false,
        "id": 14673,
        "name": "Chicken Pesto",
        "product_extra_menus": [],
        "products": [],
        "restaurant_id": 45856
      },
      {
        "hidden": false,
        "id": 14670,
        "name": "Romana",
        "product_extra_menus": [],
        "products": [],
        "restaurant_id": 45856
      },
      {
        "hidden": false,
        "id": 14671,
        "name": "Maltija",
        "product_extra_menus": [],
        "products": [],
        "restaurant_id": 45856
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
  "menu_id": 14673,
  "restaurant_id": 45856
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
        "hidden": false,
        "id": 14672,
        "name": "Bolognese",
        "product_extra_menus": [],
        "products": [],
        "restaurant_id": 45856
      },
      {
        "hidden": false,
        "id": 14670,
        "name": "Romana",
        "product_extra_menus": [],
        "products": [],
        "restaurant_id": 45856
      },
      {
        "hidden": false,
        "id": 14671,
        "name": "Maltija",
        "product_extra_menus": [],
        "products": [],
        "restaurant_id": 45856
      },
      {
        "hidden": false,
        "id": 14673,
        "name": "Chicken Pesto",
        "product_extra_menus": [],
        "products": [],
        "restaurant_id": 45856
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
  "user_id": 55030
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
  "menu_id": 14663
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
        "hidden": true,
        "id": 7939,
        "inserted_at": "2020-08-13T00:52:05",
        "menu_id": 14663,
        "name": "Medium Margherita",
        "price": {
          "amount": 9607,
          "currency": "SEK"
        },
        "price_to_string": "96,07:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 7940,
        "inserted_at": "2020-08-13T00:52:05",
        "menu_id": 14663,
        "name": "30\" with Asiago, Egg, Salami, and Chicken",
        "price": {
          "amount": 9480,
          "currency": "SEK"
        },
        "price_to_string": "94,80:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 7941,
        "inserted_at": "2020-08-13T00:52:05",
        "menu_id": 14663,
        "name": "Extra-Large Deep Dish Poutine",
        "price": {
          "amount": 8474,
          "currency": "SEK"
        },
        "price_to_string": "84,74:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 7942,
        "inserted_at": "2020-08-13T00:52:05",
        "menu_id": 14663,
        "name": "10\" Sweet Potato Crust Frutti di mare",
        "price": {
          "amount": 7522,
          "currency": "SEK"
        },
        "price_to_string": "75,22:-",
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
  "hidden": false,
  "menu_id": 14656,
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
    "id": 7929,
    "inserted_at": "2020-08-13T00:52:05",
    "menu_id": 14656,
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
    "id": 7929,
    "inserted_at": "2020-08-13T00:52:05",
    "menu_id": 14656,
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
  "restaurant_id": 45825
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "hidden": true,
    "id": 7924,
    "inserted_at": "2020-08-13T00:52:05",
    "menu_id": null,
    "name": "test product 29",
    "price": {
      "amount": 2900,
      "currency": "SEK"
    },
    "price_to_string": "29:-",
    "product_extra_menus": [],
    "restaurant_id": 45825
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
  "product_id": 7938
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "hidden": true,
    "id": 7938,
    "inserted_at": "2020-08-13T00:52:05",
    "menu_id": 14662,
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
    "hidden": true,
    "id": 7938,
    "inserted_at": "2020-08-13T00:52:05",
    "menu_id": 14662,
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
  "product_id": 7945
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted product 'Personal Bacon Cheeseburger ' with id 7945"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ merchandise:lobby
* __Event:__ product_deleted
* __Body:__
```json
{
  "message": "Deleted product 'Personal Bacon Cheeseburger '",
  "product_id": 7945
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
  "menu_id": 14659
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
        "hidden": true,
        "id": 7932,
        "inserted_at": "2020-08-13T00:52:05",
        "menu_id": 14659,
        "name": "10\" Four Seasons",
        "price": {
          "amount": 8369,
          "currency": "SEK"
        },
        "price_to_string": "83,69:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 7933,
        "inserted_at": "2020-08-13T00:52:05",
        "menu_id": 14659,
        "name": "Extra-Large New York Style with Salmon, Steak, and Caramelised Onions",
        "price": {
          "amount": 7280,
          "currency": "SEK"
        },
        "price_to_string": "72,80:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 7934,
        "inserted_at": "2020-08-13T00:52:05",
        "menu_id": 14659,
        "name": "Personal with Spicy Tomato Sauce, Mackerel, Scallops, and Chorizo",
        "price": {
          "amount": 9851,
          "currency": "SEK"
        },
        "price_to_string": "98,51:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 7935,
        "inserted_at": "2020-08-13T00:52:05",
        "menu_id": 14659,
        "name": "16\" with Philly Steak, Classic Tomato Sauce, and Fior di latte",
        "price": {
          "amount": 7642,
          "currency": "SEK"
        },
        "price_to_string": "76,42:-",
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
  "menu_id": 14659,
  "product_id": 7935
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
        "hidden": true,
        "id": 7932,
        "inserted_at": "2020-08-13T00:52:05",
        "menu_id": 14659,
        "name": "10\" Four Seasons",
        "price": {
          "amount": 8369,
          "currency": "SEK"
        },
        "price_to_string": "83,69:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 7935,
        "inserted_at": "2020-08-13T00:52:05",
        "menu_id": 14659,
        "name": "16\" with Philly Steak, Classic Tomato Sauce, and Fior di latte",
        "price": {
          "amount": 7642,
          "currency": "SEK"
        },
        "price_to_string": "76,42:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 7933,
        "inserted_at": "2020-08-13T00:52:05",
        "menu_id": 14659,
        "name": "Extra-Large New York Style with Salmon, Steak, and Caramelised Onions",
        "price": {
          "amount": 7280,
          "currency": "SEK"
        },
        "price_to_string": "72,80:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 7934,
        "inserted_at": "2020-08-13T00:52:05",
        "menu_id": 14659,
        "name": "Personal with Spicy Tomato Sauce, Mackerel, Scallops, and Chorizo",
        "price": {
          "amount": 9851,
          "currency": "SEK"
        },
        "price_to_string": "98,51:-",
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
  "menu_id": 14659,
  "product_id": 7934
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
        "hidden": true,
        "id": 7932,
        "inserted_at": "2020-08-13T00:52:05",
        "menu_id": 14659,
        "name": "10\" Four Seasons",
        "price": {
          "amount": 8369,
          "currency": "SEK"
        },
        "price_to_string": "83,69:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 7935,
        "inserted_at": "2020-08-13T00:52:05",
        "menu_id": 14659,
        "name": "16\" with Philly Steak, Classic Tomato Sauce, and Fior di latte",
        "price": {
          "amount": 7642,
          "currency": "SEK"
        },
        "price_to_string": "76,42:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 7934,
        "inserted_at": "2020-08-13T00:52:05",
        "menu_id": 14659,
        "name": "Personal with Spicy Tomato Sauce, Mackerel, Scallops, and Chorizo",
        "price": {
          "amount": 9851,
          "currency": "SEK"
        },
        "price_to_string": "98,51:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 7933,
        "inserted_at": "2020-08-13T00:52:05",
        "menu_id": 14659,
        "name": "Extra-Large New York Style with Salmon, Steak, and Caramelised Onions",
        "price": {
          "amount": 7280,
          "currency": "SEK"
        },
        "price_to_string": "72,80:-",
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
  "menu_id": 14659,
  "product_id": 7932
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
        "hidden": true,
        "id": 7935,
        "inserted_at": "2020-08-13T00:52:05",
        "menu_id": 14659,
        "name": "16\" with Philly Steak, Classic Tomato Sauce, and Fior di latte",
        "price": {
          "amount": 7642,
          "currency": "SEK"
        },
        "price_to_string": "76,42:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 7932,
        "inserted_at": "2020-08-13T00:52:05",
        "menu_id": 14659,
        "name": "10\" Four Seasons",
        "price": {
          "amount": 8369,
          "currency": "SEK"
        },
        "price_to_string": "83,69:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 7934,
        "inserted_at": "2020-08-13T00:52:05",
        "menu_id": 14659,
        "name": "Personal with Spicy Tomato Sauce, Mackerel, Scallops, and Chorizo",
        "price": {
          "amount": 9851,
          "currency": "SEK"
        },
        "price_to_string": "98,51:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 7933,
        "inserted_at": "2020-08-13T00:52:05",
        "menu_id": 14659,
        "name": "Extra-Large New York Style with Salmon, Steak, and Caramelised Onions",
        "price": {
          "amount": 7280,
          "currency": "SEK"
        },
        "price_to_string": "72,80:-",
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
  "menu_id": 14659,
  "product_id": 7934
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
        "hidden": true,
        "id": 7934,
        "inserted_at": "2020-08-13T00:52:05",
        "menu_id": 14659,
        "name": "Personal with Spicy Tomato Sauce, Mackerel, Scallops, and Chorizo",
        "price": {
          "amount": 9851,
          "currency": "SEK"
        },
        "price_to_string": "98,51:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 7935,
        "inserted_at": "2020-08-13T00:52:05",
        "menu_id": 14659,
        "name": "16\" with Philly Steak, Classic Tomato Sauce, and Fior di latte",
        "price": {
          "amount": 7642,
          "currency": "SEK"
        },
        "price_to_string": "76,42:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 7932,
        "inserted_at": "2020-08-13T00:52:05",
        "menu_id": 14659,
        "name": "10\" Four Seasons",
        "price": {
          "amount": 8369,
          "currency": "SEK"
        },
        "price_to_string": "83,69:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 7933,
        "inserted_at": "2020-08-13T00:52:05",
        "menu_id": 14659,
        "name": "Extra-Large New York Style with Salmon, Steak, and Caramelised Onions",
        "price": {
          "amount": 7280,
          "currency": "SEK"
        },
        "price_to_string": "72,80:-",
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
  "menu_id": 14659,
  "product_id": 7935
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
        "hidden": true,
        "id": 7934,
        "inserted_at": "2020-08-13T00:52:05",
        "menu_id": 14659,
        "name": "Personal with Spicy Tomato Sauce, Mackerel, Scallops, and Chorizo",
        "price": {
          "amount": 9851,
          "currency": "SEK"
        },
        "price_to_string": "98,51:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 7932,
        "inserted_at": "2020-08-13T00:52:05",
        "menu_id": 14659,
        "name": "10\" Four Seasons",
        "price": {
          "amount": 8369,
          "currency": "SEK"
        },
        "price_to_string": "83,69:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 7933,
        "inserted_at": "2020-08-13T00:52:05",
        "menu_id": 14659,
        "name": "Extra-Large New York Style with Salmon, Steak, and Caramelised Onions",
        "price": {
          "amount": 7280,
          "currency": "SEK"
        },
        "price_to_string": "72,80:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 7935,
        "inserted_at": "2020-08-13T00:52:05",
        "menu_id": 14659,
        "name": "16\" with Philly Steak, Classic Tomato Sauce, and Fior di latte",
        "price": {
          "amount": 7642,
          "currency": "SEK"
        },
        "price_to_string": "76,42:-",
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
  "params": {
    "hidden": false,
    "name": "Sauces",
    "product_id": 7927
  }
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "default_extra": null,
    "hidden": false,
    "id": 1681,
    "inserted_at": "2020-08-13T00:52:05",
    "mandatory": false,
    "name": "Sauces",
    "pick_only_one": false,
    "product_extras": [],
    "product_id": 7927
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
    "hidden": false,
    "id": 1681,
    "inserted_at": "2020-08-13T00:52:05",
    "mandatory": false,
    "name": "Sauces",
    "pick_only_one": false,
    "product_extras": [],
    "product_id": 7927
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
  "product_extra_menu_id": 1685
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "default_extra": null,
    "hidden": false,
    "id": 1685,
    "inserted_at": "2020-08-13T00:52:06",
    "mandatory": true,
    "name": "Must Pick One Sauce",
    "pick_only_one": true,
    "product_extras": [],
    "product_id": 7946
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
    "hidden": false,
    "id": 1685,
    "inserted_at": "2020-08-13T00:52:06",
    "mandatory": true,
    "name": "Must Pick One Sauce",
    "pick_only_one": true,
    "product_extras": [],
    "product_id": 7946
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
  "product_extra_menu_id": 1682
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted product extra menu: 'Sauces' with id 1682"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ merchandise:lobby
* __Event:__ product_extra_menu_deleted
* __Body:__
```json
{
  "message": "Deleted product extra menu: 'Sauces'",
  "product_extra_menu_id": 1682
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
  "hidden": false,
  "new_name": "Romesco Sauce",
  "new_price": 1000,
  "product_extra_menu_id": 1683,
  "product_id": 7937
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "hidden": false,
    "id": 1192,
    "inserted_at": "2020-08-13T00:52:05",
    "new_name": "Romesco Sauce",
    "new_price": {
      "amount": 1000,
      "currency": "SEK"
    },
    "new_price_to_string": "10:-",
    "product": {
      "hidden": false,
      "id": 7937,
      "inserted_at": "2020-08-13T00:52:05",
      "menu_id": null,
      "name": "Romesco Sauce",
      "price": {
        "amount": 4465,
        "currency": "SEK"
      },
      "price_to_string": "44,65:-",
      "restaurant_id": 45835
    },
    "product_extra_menu_id": 1683,
    "product_id": 7937
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
    "id": 1192,
    "inserted_at": "2020-08-13T00:52:05",
    "new_name": "Romesco Sauce",
    "new_price": {
      "amount": 1000,
      "currency": "SEK"
    },
    "new_price_to_string": "10:-",
    "product": {
      "hidden": false,
      "id": 7937,
      "inserted_at": "2020-08-13T00:52:05",
      "menu_id": null,
      "name": "Romesco Sauce",
      "price": {
        "amount": 4465,
        "currency": "SEK"
      },
      "price_to_string": "44,65:-",
      "restaurant_id": 45835
    },
    "product_extra_menu_id": 1683,
    "product_id": 7937
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
  "product_extra_id": 1191
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "hidden": false,
    "id": 1191,
    "inserted_at": "2020-08-13T00:52:05",
    "new_name": "Sauce X",
    "new_price": {
      "amount": 900,
      "currency": "SEK"
    },
    "new_price_to_string": "9:-",
    "product": {
      "hidden": false,
      "id": 7926,
      "inserted_at": "2020-08-13T00:52:05",
      "menu_id": null,
      "name": "Spicy Tomato Sauce",
      "price": {
        "amount": 4963,
        "currency": "SEK"
      },
      "price_to_string": "49,63:-",
      "restaurant_id": 45826
    },
    "product_extra_menu_id": 1680,
    "product_id": 7926
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
    "id": 1191,
    "inserted_at": "2020-08-13T00:52:05",
    "new_name": "Sauce X",
    "new_price": {
      "amount": 900,
      "currency": "SEK"
    },
    "new_price_to_string": "9:-",
    "product": {
      "hidden": false,
      "id": 7926,
      "inserted_at": "2020-08-13T00:52:05",
      "menu_id": null,
      "name": "Spicy Tomato Sauce",
      "price": {
        "amount": 4963,
        "currency": "SEK"
      },
      "price_to_string": "49,63:-",
      "restaurant_id": 45826
    },
    "product_extra_menu_id": 1680,
    "product_id": 7926
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
  "product_extra_id": 1193
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted product extra: 'Sauce Y' with id 1193"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ merchandise:lobby
* __Event:__ product_extra_deleted
* __Body:__
```json
{
  "message": "Deleted product extra: 'Sauce Y'",
  "product_extra_id": 1193
}
```
---
