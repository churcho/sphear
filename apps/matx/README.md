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
  "email": "user-576460752303423070@example.com",
  "password": "hello world!"
}
```

##### ← <ins>Response to you</ins>
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FiisDGuAW4BeTHsAAAFF
```
* __Response body:__
```json
{
  "success": {
    "token": "Dq40oJBkwsaHHAQ5jWUEZfwyql60GiVSmIXZIwP8pdU="
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
  "email": "user-576460752303421855@example.com",
  "password": "lol"
}
```

##### ← <ins>Response to you</ins>
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FiisDGfOUAC1_LcAAAaB
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
  "email": "user-576460752303421759@example.com",
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
x-request-id: FiisDGuAW4DOkysAAAbh
```
* __Response body:__
```json
{
  "success": {
    "email": "user-576460752303421759@example.com",
    "token": "AKxbkUzQV/lNrW75O3GAEp2yrFg6bqrZFgrL4UrzeFs="
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
x-request-id: FiisDGfOUABfUTwAAAah
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
  "user_id": 51198
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
        "address": "1 Bahringer Rest",
        "created": "2020-08-06T12:00:39",
        "hidden": false,
        "id": 41233,
        "menus": [],
        "name": "Pizza Planet",
        "unlisted_products": [],
        "url": "https://pizza-planet.se"
      },
      {
        "address": "934 Bernie Mill",
        "created": "2020-08-06T12:00:39",
        "hidden": false,
        "id": 41234,
        "menus": [],
        "name": "Paisanos",
        "unlisted_products": [],
        "url": "https://paisanos.se"
      },
      {
        "address": "4176 Boyer Well",
        "created": "2020-08-06T12:00:39",
        "hidden": false,
        "id": 41235,
        "menus": [],
        "name": "Little Nero's Pizza",
        "unlisted_products": [],
        "url": "https://little-neros-pizza.se"
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
  "restaurant_id": 41259
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "address": "55668 Schultz Corner",
    "created": "2020-08-06T12:00:40",
    "hidden": false,
    "id": 41259,
    "menus": [
      {
        "hidden": false,
        "id": 12293,
        "name": "Bolognese",
        "products": [
          {
            "hidden": true,
            "id": 5879,
            "inserted_at": "2020-08-06T12:00:40",
            "menu_id": 12293,
            "name": "Personal Deep Dish Romana",
            "price": {
              "amount": 8482,
              "currency": "SEK"
            },
            "price_to_string": "84,82:-",
            "product_extra_menus": [
              {
                "default_extra": null,
                "hidden": false,
                "id": 984,
                "inserted_at": "2020-08-06T12:00:40",
                "mandatory": false,
                "name": "Extras",
                "pick_only_one": false,
                "product_extras": [
                  {
                    "hidden": false,
                    "id": 715,
                    "inserted_at": "2020-08-06T12:00:40",
                    "new_name": "Huge Pommes",
                    "new_price": {
                      "amount": 6422,
                      "currency": "SEK"
                    },
                    "new_price_to_string": "64,22:-",
                    "product": {
                      "hidden": false,
                      "id": 5883,
                      "inserted_at": "2020-08-06T12:00:40",
                      "menu_id": null,
                      "name": "Pommes",
                      "price": {
                        "amount": 4489,
                        "currency": "SEK"
                      },
                      "price_to_string": "44,89:-",
                      "restaurant_id": 41259
                    },
                    "product_extra_menu_id": 984,
                    "product_id": 5883
                  },
                  {
                    "hidden": false,
                    "id": 714,
                    "inserted_at": "2020-08-06T12:00:40",
                    "new_name": "Big Pommes",
                    "new_price": {
                      "amount": 5454,
                      "currency": "SEK"
                    },
                    "new_price_to_string": "54,54:-",
                    "product": {
                      "hidden": false,
                      "id": 5883,
                      "inserted_at": "2020-08-06T12:00:40",
                      "menu_id": null,
                      "name": "Pommes",
                      "price": {
                        "amount": 4489,
                        "currency": "SEK"
                      },
                      "price_to_string": "44,89:-",
                      "restaurant_id": 41259
                    },
                    "product_extra_menu_id": 984,
                    "product_id": 5883
                  },
                  {
                    "hidden": false,
                    "id": 713,
                    "inserted_at": "2020-08-06T12:00:40",
                    "new_name": "Medium Pommes",
                    "new_price": {
                      "amount": 3208,
                      "currency": "SEK"
                    },
                    "new_price_to_string": "32,08:-",
                    "product": {
                      "hidden": false,
                      "id": 5883,
                      "inserted_at": "2020-08-06T12:00:40",
                      "menu_id": null,
                      "name": "Pommes",
                      "price": {
                        "amount": 4489,
                        "currency": "SEK"
                      },
                      "price_to_string": "44,89:-",
                      "restaurant_id": 41259
                    },
                    "product_extra_menu_id": 984,
                    "product_id": 5883
                  },
                  {
                    "hidden": false,
                    "id": 712,
                    "inserted_at": "2020-08-06T12:00:40",
                    "new_name": "Small Pommes",
                    "new_price": {
                      "amount": 1823,
                      "currency": "SEK"
                    },
                    "new_price_to_string": "18,23:-",
                    "product": {
                      "hidden": false,
                      "id": 5883,
                      "inserted_at": "2020-08-06T12:00:40",
                      "menu_id": null,
                      "name": "Pommes",
                      "price": {
                        "amount": 4489,
                        "currency": "SEK"
                      },
                      "price_to_string": "44,89:-",
                      "restaurant_id": 41259
                    },
                    "product_extra_menu_id": 984,
                    "product_id": 5883
                  }
                ],
                "product_id": 5879
              }
            ],
            "restaurant_id": null
          },
          {
            "hidden": true,
            "id": 5880,
            "inserted_at": "2020-08-06T12:00:40",
            "menu_id": 12293,
            "name": "26\" Taco",
            "price": {
              "amount": 9235,
              "currency": "SEK"
            },
            "price_to_string": "92,35:-",
            "product_extra_menus": [],
            "restaurant_id": null
          },
          {
            "hidden": true,
            "id": 5881,
            "inserted_at": "2020-08-06T12:00:40",
            "menu_id": 12293,
            "name": "Personal Meat Feast",
            "price": {
              "amount": 7295,
              "currency": "SEK"
            },
            "price_to_string": "72,95:-",
            "product_extra_menus": [],
            "restaurant_id": null
          },
          {
            "hidden": true,
            "id": 5882,
            "inserted_at": "2020-08-06T12:00:40",
            "menu_id": 12293,
            "name": "Personal Grandma",
            "price": {
              "amount": 7627,
              "currency": "SEK"
            },
            "price_to_string": "76,27:-",
            "product_extra_menus": [],
            "restaurant_id": null
          }
        ],
        "restaurant_id": 41259
      }
    ],
    "name": "Pizza Forest",
    "unlisted_products": [
      {
        "hidden": false,
        "id": 5883,
        "inserted_at": "2020-08-06T12:00:40",
        "menu_id": null,
        "name": "Pommes",
        "price": {
          "amount": 4489,
          "currency": "SEK"
        },
        "price_to_string": "44,89:-",
        "product_extra_menus": [],
        "restaurant_id": 41259
      }
    ],
    "url": "https://pizza-forest.se"
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
  "restaurant_id": 41249
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
        "id": 12288,
        "name": "Canadian",
        "products": [],
        "restaurant_id": 41249
      },
      {
        "hidden": false,
        "id": 12289,
        "name": "Thai Chicken",
        "products": [],
        "restaurant_id": 41249
      },
      {
        "hidden": false,
        "id": 12290,
        "name": "Quattro Formaggio",
        "products": [],
        "restaurant_id": 41249
      },
      {
        "hidden": false,
        "id": 12291,
        "name": "Shrimp Club",
        "products": [],
        "restaurant_id": 41249
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
  "menu_id": 12279
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "hidden": false,
    "id": 12279,
    "name": "Africana",
    "products": [],
    "restaurant_id": 41218
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
    "created": "2020-08-06T12:00:39",
    "hidden": false,
    "id": 41229,
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
    "created": "2020-08-06T12:00:39",
    "hidden": false,
    "id": 41229,
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
  "restaurant_id": 41256
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "address": "8819 Angeline Square",
    "created": "2020-08-06T12:00:40",
    "hidden": false,
    "id": 41256,
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
    "address": "8819 Angeline Square",
    "created": "2020-08-06T12:00:40",
    "hidden": false,
    "id": 41256,
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
  "restaurant_id": 41220
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted restaurant 'Dinosaur Pizza' with id 41220"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ restaurants:lobby
* __Event:__ restaurant_deleted
* __Body:__
```json
{
  "message": "Deleted restaurant 'Dinosaur Pizza'",
  "restaurant_id": 41220
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
  "restaurant_id": 41246
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "hidden": false,
    "id": 12287,
    "name": "test menu",
    "products": [],
    "restaurant_id": 41246
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
    "id": 12287,
    "name": "test menu",
    "products": [],
    "restaurant_id": 41246
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
  "menu_id": 12292,
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
    "id": 12292,
    "name": "some new name",
    "products": [],
    "restaurant_id": 41254
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
    "id": 12292,
    "name": "some new name",
    "products": [],
    "restaurant_id": 41254
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
  "menu_id": 12286
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted menu 'test menu1' with id 12286"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ restaurants:lobby
* __Event:__ menu_deleted
* __Body:__
```json
{
  "menu_id": 12286,
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
  "restaurant_id": 41224
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "address": "41 Boehm Corner",
    "created": "2020-08-06T12:00:39",
    "hidden": false,
    "id": 41224,
    "menus": [
      {
        "hidden": false,
        "id": 12281,
        "name": "Meat Lovers",
        "products": [],
        "restaurant_id": 41224
      },
      {
        "hidden": false,
        "id": 12282,
        "name": "Vegetarian Lovers",
        "products": [],
        "restaurant_id": 41224
      },
      {
        "hidden": false,
        "id": 12283,
        "name": "Chicken Pesto",
        "products": [],
        "restaurant_id": 41224
      },
      {
        "hidden": false,
        "id": 12284,
        "name": "Meatball ",
        "products": [],
        "restaurant_id": 41224
      }
    ],
    "name": "Sid’s Pizza Parlor",
    "unlisted_products": [],
    "url": "https://sids-pizza-parlor.se"
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
  "menu_id": 12284,
  "restaurant_id": 41224
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
        "id": 12281,
        "name": "Meat Lovers",
        "products": [],
        "restaurant_id": 41224
      },
      {
        "hidden": false,
        "id": 12284,
        "name": "Meatball ",
        "products": [],
        "restaurant_id": 41224
      },
      {
        "hidden": false,
        "id": 12282,
        "name": "Vegetarian Lovers",
        "products": [],
        "restaurant_id": 41224
      },
      {
        "hidden": false,
        "id": 12283,
        "name": "Chicken Pesto",
        "products": [],
        "restaurant_id": 41224
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
  "menu_id": 12283,
  "restaurant_id": 41224
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
        "id": 12281,
        "name": "Meat Lovers",
        "products": [],
        "restaurant_id": 41224
      },
      {
        "hidden": false,
        "id": 12284,
        "name": "Meatball ",
        "products": [],
        "restaurant_id": 41224
      },
      {
        "hidden": false,
        "id": 12283,
        "name": "Chicken Pesto",
        "products": [],
        "restaurant_id": 41224
      },
      {
        "hidden": false,
        "id": 12282,
        "name": "Vegetarian Lovers",
        "products": [],
        "restaurant_id": 41224
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
  "menu_id": 12281,
  "restaurant_id": 41224
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
        "id": 12284,
        "name": "Meatball ",
        "products": [],
        "restaurant_id": 41224
      },
      {
        "hidden": false,
        "id": 12281,
        "name": "Meat Lovers",
        "products": [],
        "restaurant_id": 41224
      },
      {
        "hidden": false,
        "id": 12283,
        "name": "Chicken Pesto",
        "products": [],
        "restaurant_id": 41224
      },
      {
        "hidden": false,
        "id": 12282,
        "name": "Vegetarian Lovers",
        "products": [],
        "restaurant_id": 41224
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
  "menu_id": 12283,
  "restaurant_id": 41224
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
        "id": 12283,
        "name": "Chicken Pesto",
        "products": [],
        "restaurant_id": 41224
      },
      {
        "hidden": false,
        "id": 12284,
        "name": "Meatball ",
        "products": [],
        "restaurant_id": 41224
      },
      {
        "hidden": false,
        "id": 12281,
        "name": "Meat Lovers",
        "products": [],
        "restaurant_id": 41224
      },
      {
        "hidden": false,
        "id": 12282,
        "name": "Vegetarian Lovers",
        "products": [],
        "restaurant_id": 41224
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
  "menu_id": 12284,
  "restaurant_id": 41224
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
        "id": 12283,
        "name": "Chicken Pesto",
        "products": [],
        "restaurant_id": 41224
      },
      {
        "hidden": false,
        "id": 12281,
        "name": "Meat Lovers",
        "products": [],
        "restaurant_id": 41224
      },
      {
        "hidden": false,
        "id": 12282,
        "name": "Vegetarian Lovers",
        "products": [],
        "restaurant_id": 41224
      },
      {
        "hidden": false,
        "id": 12284,
        "name": "Meatball ",
        "products": [],
        "restaurant_id": 41224
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
  "user_id": 51176
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
  "menu_id": 12271
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
        "id": 5864,
        "inserted_at": "2020-08-06T12:00:38",
        "menu_id": 12271,
        "name": "Extra-Large Margherita",
        "price": {
          "amount": 7776,
          "currency": "SEK"
        },
        "price_to_string": "77,76:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5865,
        "inserted_at": "2020-08-06T12:00:38",
        "menu_id": 12271,
        "name": "Large Deep Dish Breakfast",
        "price": {
          "amount": 9913,
          "currency": "SEK"
        },
        "price_to_string": "99,13:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5866,
        "inserted_at": "2020-08-06T12:00:38",
        "menu_id": 12271,
        "name": "Small Grandma",
        "price": {
          "amount": 9731,
          "currency": "SEK"
        },
        "price_to_string": "97,31:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5867,
        "inserted_at": "2020-08-06T12:00:38",
        "menu_id": 12271,
        "name": "18\" Quattro Formaggi",
        "price": {
          "amount": 7854,
          "currency": "SEK"
        },
        "price_to_string": "78,54:-",
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
  "menu_id": 12268,
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
    "id": 5860,
    "inserted_at": "2020-08-06T12:00:38",
    "menu_id": 12268,
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
    "id": 5860,
    "inserted_at": "2020-08-06T12:00:38",
    "menu_id": 12268,
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
  "restaurant_id": 41215
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "hidden": true,
    "id": 5878,
    "inserted_at": "2020-08-06T12:00:39",
    "menu_id": null,
    "name": "test product 29",
    "price": {
      "amount": 2900,
      "currency": "SEK"
    },
    "price_to_string": "29:-",
    "product_extra_menus": [],
    "restaurant_id": 41215
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
  "product_id": 5856
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "hidden": true,
    "id": 5856,
    "inserted_at": "2020-08-06T12:00:38",
    "menu_id": 12264,
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
    "id": 5856,
    "inserted_at": "2020-08-06T12:00:38",
    "menu_id": 12264,
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
  "product_id": 5872
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted product 'Family Spooning Pizza Vegetariana' with id 5872"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ merchandise:lobby
* __Event:__ product_deleted
* __Body:__
```json
{
  "message": "Deleted product 'Family Spooning Pizza Vegetariana'",
  "product_id": 5872
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
  "menu_id": 12276
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
        "id": 5873,
        "inserted_at": "2020-08-06T12:00:39",
        "menu_id": 12276,
        "name": "14\" Veggie Korma",
        "price": {
          "amount": 9620,
          "currency": "SEK"
        },
        "price_to_string": "96,20:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5874,
        "inserted_at": "2020-08-06T12:00:39",
        "menu_id": 12276,
        "name": "Extra-Large Funghi",
        "price": {
          "amount": 9747,
          "currency": "SEK"
        },
        "price_to_string": "97,47:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5875,
        "inserted_at": "2020-08-06T12:00:39",
        "menu_id": 12276,
        "name": "Small Grilled with Classic Tomato Sauce, Shrimps, Mutton, and Canadian Bacon",
        "price": {
          "amount": 8735,
          "currency": "SEK"
        },
        "price_to_string": "87,35:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5876,
        "inserted_at": "2020-08-06T12:00:39",
        "menu_id": 12276,
        "name": "Family Bacon Cheeseburger ",
        "price": {
          "amount": 8053,
          "currency": "SEK"
        },
        "price_to_string": "80,53:-",
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
  "menu_id": 12276,
  "product_id": 5876
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
        "id": 5873,
        "inserted_at": "2020-08-06T12:00:39",
        "menu_id": 12276,
        "name": "14\" Veggie Korma",
        "price": {
          "amount": 9620,
          "currency": "SEK"
        },
        "price_to_string": "96,20:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5876,
        "inserted_at": "2020-08-06T12:00:39",
        "menu_id": 12276,
        "name": "Family Bacon Cheeseburger ",
        "price": {
          "amount": 8053,
          "currency": "SEK"
        },
        "price_to_string": "80,53:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5874,
        "inserted_at": "2020-08-06T12:00:39",
        "menu_id": 12276,
        "name": "Extra-Large Funghi",
        "price": {
          "amount": 9747,
          "currency": "SEK"
        },
        "price_to_string": "97,47:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5875,
        "inserted_at": "2020-08-06T12:00:39",
        "menu_id": 12276,
        "name": "Small Grilled with Classic Tomato Sauce, Shrimps, Mutton, and Canadian Bacon",
        "price": {
          "amount": 8735,
          "currency": "SEK"
        },
        "price_to_string": "87,35:-",
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
  "menu_id": 12276,
  "product_id": 5875
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
        "id": 5873,
        "inserted_at": "2020-08-06T12:00:39",
        "menu_id": 12276,
        "name": "14\" Veggie Korma",
        "price": {
          "amount": 9620,
          "currency": "SEK"
        },
        "price_to_string": "96,20:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5876,
        "inserted_at": "2020-08-06T12:00:39",
        "menu_id": 12276,
        "name": "Family Bacon Cheeseburger ",
        "price": {
          "amount": 8053,
          "currency": "SEK"
        },
        "price_to_string": "80,53:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5875,
        "inserted_at": "2020-08-06T12:00:39",
        "menu_id": 12276,
        "name": "Small Grilled with Classic Tomato Sauce, Shrimps, Mutton, and Canadian Bacon",
        "price": {
          "amount": 8735,
          "currency": "SEK"
        },
        "price_to_string": "87,35:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5874,
        "inserted_at": "2020-08-06T12:00:39",
        "menu_id": 12276,
        "name": "Extra-Large Funghi",
        "price": {
          "amount": 9747,
          "currency": "SEK"
        },
        "price_to_string": "97,47:-",
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
  "menu_id": 12276,
  "product_id": 5873
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
        "id": 5876,
        "inserted_at": "2020-08-06T12:00:39",
        "menu_id": 12276,
        "name": "Family Bacon Cheeseburger ",
        "price": {
          "amount": 8053,
          "currency": "SEK"
        },
        "price_to_string": "80,53:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5873,
        "inserted_at": "2020-08-06T12:00:39",
        "menu_id": 12276,
        "name": "14\" Veggie Korma",
        "price": {
          "amount": 9620,
          "currency": "SEK"
        },
        "price_to_string": "96,20:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5875,
        "inserted_at": "2020-08-06T12:00:39",
        "menu_id": 12276,
        "name": "Small Grilled with Classic Tomato Sauce, Shrimps, Mutton, and Canadian Bacon",
        "price": {
          "amount": 8735,
          "currency": "SEK"
        },
        "price_to_string": "87,35:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5874,
        "inserted_at": "2020-08-06T12:00:39",
        "menu_id": 12276,
        "name": "Extra-Large Funghi",
        "price": {
          "amount": 9747,
          "currency": "SEK"
        },
        "price_to_string": "97,47:-",
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
  "menu_id": 12276,
  "product_id": 5875
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
        "id": 5875,
        "inserted_at": "2020-08-06T12:00:39",
        "menu_id": 12276,
        "name": "Small Grilled with Classic Tomato Sauce, Shrimps, Mutton, and Canadian Bacon",
        "price": {
          "amount": 8735,
          "currency": "SEK"
        },
        "price_to_string": "87,35:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5876,
        "inserted_at": "2020-08-06T12:00:39",
        "menu_id": 12276,
        "name": "Family Bacon Cheeseburger ",
        "price": {
          "amount": 8053,
          "currency": "SEK"
        },
        "price_to_string": "80,53:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5873,
        "inserted_at": "2020-08-06T12:00:39",
        "menu_id": 12276,
        "name": "14\" Veggie Korma",
        "price": {
          "amount": 9620,
          "currency": "SEK"
        },
        "price_to_string": "96,20:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5874,
        "inserted_at": "2020-08-06T12:00:39",
        "menu_id": 12276,
        "name": "Extra-Large Funghi",
        "price": {
          "amount": 9747,
          "currency": "SEK"
        },
        "price_to_string": "97,47:-",
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
  "menu_id": 12276,
  "product_id": 5876
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
        "id": 5875,
        "inserted_at": "2020-08-06T12:00:39",
        "menu_id": 12276,
        "name": "Small Grilled with Classic Tomato Sauce, Shrimps, Mutton, and Canadian Bacon",
        "price": {
          "amount": 8735,
          "currency": "SEK"
        },
        "price_to_string": "87,35:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5873,
        "inserted_at": "2020-08-06T12:00:39",
        "menu_id": 12276,
        "name": "14\" Veggie Korma",
        "price": {
          "amount": 9620,
          "currency": "SEK"
        },
        "price_to_string": "96,20:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5874,
        "inserted_at": "2020-08-06T12:00:39",
        "menu_id": 12276,
        "name": "Extra-Large Funghi",
        "price": {
          "amount": 9747,
          "currency": "SEK"
        },
        "price_to_string": "97,47:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5876,
        "inserted_at": "2020-08-06T12:00:39",
        "menu_id": 12276,
        "name": "Family Bacon Cheeseburger ",
        "price": {
          "amount": 8053,
          "currency": "SEK"
        },
        "price_to_string": "80,53:-",
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
    "product_id": 5877
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
    "id": 983,
    "inserted_at": "2020-08-06T12:00:39",
    "mandatory": false,
    "name": "Sauces",
    "pick_only_one": false,
    "product_extras": [],
    "product_id": 5877
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
    "id": 983,
    "inserted_at": "2020-08-06T12:00:39",
    "mandatory": false,
    "name": "Sauces",
    "pick_only_one": false,
    "product_extras": [],
    "product_id": 5877
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
  "product_extra_menu_id": 980
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
    "id": 980,
    "inserted_at": "2020-08-06T12:00:38",
    "mandatory": true,
    "name": "Must Pick One Sauce",
    "pick_only_one": true,
    "product_extras": [],
    "product_id": 5863
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
    "id": 980,
    "inserted_at": "2020-08-06T12:00:38",
    "mandatory": true,
    "name": "Must Pick One Sauce",
    "pick_only_one": true,
    "product_extras": [],
    "product_id": 5863
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
  "product_extra_menu_id": 978
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted product extra menu: 'Sauces' with id 978"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ merchandise:lobby
* __Event:__ product_extra_menu_deleted
* __Body:__
```json
{
  "message": "Deleted product extra menu: 'Sauces'",
  "product_extra_menu_id": 978
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
  "new_name": "Marinara Sauce",
  "new_price": 1000,
  "product_extra_menu_id": 981,
  "product_id": 5869
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "hidden": false,
    "id": 710,
    "inserted_at": "2020-08-06T12:00:38",
    "new_name": "Marinara Sauce",
    "new_price": {
      "amount": 1000,
      "currency": "SEK"
    },
    "new_price_to_string": "10:-",
    "product": {
      "hidden": false,
      "id": 5869,
      "inserted_at": "2020-08-06T12:00:38",
      "menu_id": null,
      "name": "Marinara Sauce",
      "price": {
        "amount": 4945,
        "currency": "SEK"
      },
      "price_to_string": "49,45:-",
      "restaurant_id": 41207
    },
    "product_extra_menu_id": 981,
    "product_id": 5869
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
    "id": 710,
    "inserted_at": "2020-08-06T12:00:38",
    "new_name": "Marinara Sauce",
    "new_price": {
      "amount": 1000,
      "currency": "SEK"
    },
    "new_price_to_string": "10:-",
    "product": {
      "hidden": false,
      "id": 5869,
      "inserted_at": "2020-08-06T12:00:38",
      "menu_id": null,
      "name": "Marinara Sauce",
      "price": {
        "amount": 4945,
        "currency": "SEK"
      },
      "price_to_string": "49,45:-",
      "restaurant_id": 41207
    },
    "product_extra_menu_id": 981,
    "product_id": 5869
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
  "product_extra_id": 711
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "hidden": false,
    "id": 711,
    "inserted_at": "2020-08-06T12:00:38",
    "new_name": "Sauce X",
    "new_price": {
      "amount": 900,
      "currency": "SEK"
    },
    "new_price_to_string": "9:-",
    "product": {
      "hidden": false,
      "id": 5871,
      "inserted_at": "2020-08-06T12:00:38",
      "menu_id": null,
      "name": "Chimichurri Sauce",
      "price": {
        "amount": 4371,
        "currency": "SEK"
      },
      "price_to_string": "43,71:-",
      "restaurant_id": 41209
    },
    "product_extra_menu_id": 982,
    "product_id": 5871
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
    "id": 711,
    "inserted_at": "2020-08-06T12:00:38",
    "new_name": "Sauce X",
    "new_price": {
      "amount": 900,
      "currency": "SEK"
    },
    "new_price_to_string": "9:-",
    "product": {
      "hidden": false,
      "id": 5871,
      "inserted_at": "2020-08-06T12:00:38",
      "menu_id": null,
      "name": "Chimichurri Sauce",
      "price": {
        "amount": 4371,
        "currency": "SEK"
      },
      "price_to_string": "43,71:-",
      "restaurant_id": 41209
    },
    "product_extra_menu_id": 982,
    "product_id": 5871
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
  "product_extra_id": 709
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted product extra: 'Sauce Y' with id 709"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ merchandise:lobby
* __Event:__ product_extra_deleted
* __Body:__
```json
{
  "message": "Deleted product extra: 'Sauce Y'",
  "product_extra_id": 709
}
```
---
