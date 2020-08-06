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
  "email": "user-576460752303422653@example.com",
  "password": "hello world!"
}
```

##### ← <ins>Response to you</ins>
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FiiHFu9CvwC1_LcAAAri
```
* __Response body:__
```json
{
  "success": {
    "token": "nUm7DzchJo9ZfDJeou5SH948JmeCKM7ZB1CzL/fN1jk="
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
  "email": "user-576460752303420638@example.com",
  "password": "lol"
}
```

##### ← <ins>Response to you</ins>
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FiiHFvTN0EDe6igAAAbB
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
  "email": "user-576460752303423322@example.com",
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
x-request-id: FiiHFu9CvwBfUTwAAArC
```
* __Response body:__
```json
{
  "success": {
    "email": "user-576460752303423322@example.com",
    "token": "edXhY4wOoTgjJRna5mLHIeqEb8QR5wPT6lkdxrgspFY="
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
x-request-id: FiiHFvTN0EBeTHsAAAsC
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
  "user_id": 50409
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
        "address": "83 Miller Meadow",
        "created": "2020-08-06T00:43:23",
        "hidden": false,
        "id": 40288,
        "menus": [],
        "name": "Pizza Joe’s",
        "unlisted_products": [],
        "url": "https://pizza-joes.se"
      },
      {
        "address": "5292 Spinka Heights",
        "created": "2020-08-06T00:43:23",
        "hidden": false,
        "id": 40289,
        "menus": [],
        "name": "Mona Pizza",
        "unlisted_products": [],
        "url": "https://mona-pizza.se"
      },
      {
        "address": "7552 Walter Key",
        "created": "2020-08-06T00:43:23",
        "hidden": false,
        "id": 40290,
        "menus": [],
        "name": "Thin Crust or Bust",
        "unlisted_products": [],
        "url": "https://thin-crust-or-bust.se"
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
  "restaurant_id": 40252
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "address": "46 Janice Light",
    "created": "2020-08-06T00:43:22",
    "hidden": false,
    "id": 40252,
    "menus": [
      {
        "hidden": false,
        "id": 11784,
        "name": "Meatball ",
        "products": [
          {
            "hidden": true,
            "id": 5439,
            "inserted_at": "2020-08-06T00:43:22",
            "menu_id": 11784,
            "name": "Medium with Mango and Gorgonzola",
            "price": {
              "amount": 7158,
              "currency": "SEK"
            },
            "price_to_string": "71,58:-",
            "product_extra_menus": [
              {
                "default_extra": null,
                "hidden": false,
                "id": 850,
                "inserted_at": "2020-08-06T00:43:22",
                "mandatory": false,
                "name": "Extras",
                "pick_only_one": false,
                "product_extras": [
                  {
                    "hidden": false,
                    "id": 616,
                    "inserted_at": "2020-08-06T00:43:22",
                    "new_name": "Huge Pommes",
                    "new_price": {
                      "amount": 7973,
                      "currency": "SEK"
                    },
                    "new_price_to_string": "79,73:-",
                    "product": {
                      "hidden": false,
                      "id": 5443,
                      "inserted_at": "2020-08-06T00:43:22",
                      "menu_id": null,
                      "name": "Pommes",
                      "price": {
                        "amount": 4401,
                        "currency": "SEK"
                      },
                      "price_to_string": "44,01:-",
                      "restaurant_id": 40252
                    },
                    "product_extra_menu_id": 850,
                    "product_id": 5443
                  },
                  {
                    "hidden": false,
                    "id": 615,
                    "inserted_at": "2020-08-06T00:43:22",
                    "new_name": "Big Pommes",
                    "new_price": {
                      "amount": 5160,
                      "currency": "SEK"
                    },
                    "new_price_to_string": "51,60:-",
                    "product": {
                      "hidden": false,
                      "id": 5443,
                      "inserted_at": "2020-08-06T00:43:22",
                      "menu_id": null,
                      "name": "Pommes",
                      "price": {
                        "amount": 4401,
                        "currency": "SEK"
                      },
                      "price_to_string": "44,01:-",
                      "restaurant_id": 40252
                    },
                    "product_extra_menu_id": 850,
                    "product_id": 5443
                  },
                  {
                    "hidden": false,
                    "id": 614,
                    "inserted_at": "2020-08-06T00:43:22",
                    "new_name": "Medium Pommes",
                    "new_price": {
                      "amount": 3504,
                      "currency": "SEK"
                    },
                    "new_price_to_string": "35,04:-",
                    "product": {
                      "hidden": false,
                      "id": 5443,
                      "inserted_at": "2020-08-06T00:43:22",
                      "menu_id": null,
                      "name": "Pommes",
                      "price": {
                        "amount": 4401,
                        "currency": "SEK"
                      },
                      "price_to_string": "44,01:-",
                      "restaurant_id": 40252
                    },
                    "product_extra_menu_id": 850,
                    "product_id": 5443
                  },
                  {
                    "hidden": false,
                    "id": 613,
                    "inserted_at": "2020-08-06T00:43:22",
                    "new_name": "Small Pommes",
                    "new_price": {
                      "amount": 1812,
                      "currency": "SEK"
                    },
                    "new_price_to_string": "18,12:-",
                    "product": {
                      "hidden": false,
                      "id": 5443,
                      "inserted_at": "2020-08-06T00:43:22",
                      "menu_id": null,
                      "name": "Pommes",
                      "price": {
                        "amount": 4401,
                        "currency": "SEK"
                      },
                      "price_to_string": "44,01:-",
                      "restaurant_id": 40252
                    },
                    "product_extra_menu_id": 850,
                    "product_id": 5443
                  }
                ],
                "product_id": 5439
              }
            ],
            "restaurant_id": null
          },
          {
            "hidden": true,
            "id": 5440,
            "inserted_at": "2020-08-06T00:43:22",
            "menu_id": 11784,
            "name": "14\" Fajita",
            "price": {
              "amount": 9672,
              "currency": "SEK"
            },
            "price_to_string": "96,72:-",
            "product_extra_menus": [],
            "restaurant_id": null
          },
          {
            "hidden": true,
            "id": 5441,
            "inserted_at": "2020-08-06T00:43:22",
            "menu_id": 11784,
            "name": "16\" Pizza Frittata with Philly Steak, Philly Steak, and Mango",
            "price": {
              "amount": 9356,
              "currency": "SEK"
            },
            "price_to_string": "93,56:-",
            "product_extra_menus": [],
            "restaurant_id": null
          },
          {
            "hidden": true,
            "id": 5442,
            "inserted_at": "2020-08-06T00:43:22",
            "menu_id": 11784,
            "name": "Family Caprese",
            "price": {
              "amount": 8545,
              "currency": "SEK"
            },
            "price_to_string": "85,45:-",
            "product_extra_menus": [],
            "restaurant_id": null
          }
        ],
        "restaurant_id": 40252
      }
    ],
    "name": "Freddy Fazbear's Pizza",
    "unlisted_products": [
      {
        "hidden": false,
        "id": 5443,
        "inserted_at": "2020-08-06T00:43:22",
        "menu_id": null,
        "name": "Pommes",
        "price": {
          "amount": 4401,
          "currency": "SEK"
        },
        "price_to_string": "44,01:-",
        "product_extra_menus": [],
        "restaurant_id": 40252
      }
    ],
    "url": "https://freddy-fazbears-pizza.se"
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
  "restaurant_id": 40293
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
        "id": 11793,
        "name": "Pesto Chicken",
        "products": [],
        "restaurant_id": 40293
      },
      {
        "hidden": false,
        "id": 11794,
        "name": "Loaded",
        "products": [],
        "restaurant_id": 40293
      },
      {
        "hidden": false,
        "id": 11795,
        "name": "Veggie Korma",
        "products": [],
        "restaurant_id": 40293
      },
      {
        "hidden": false,
        "id": 11796,
        "name": "Maltija",
        "products": [],
        "restaurant_id": 40293
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
  "menu_id": 11791
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "hidden": false,
    "id": 11791,
    "name": "Hot & Spicy",
    "products": [],
    "restaurant_id": 40277
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
    "created": "2020-08-06T00:43:22",
    "hidden": false,
    "id": 40250,
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
    "created": "2020-08-06T00:43:22",
    "hidden": false,
    "id": 40250,
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
  "restaurant_id": 40266
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "address": "63003 Aisha Lock",
    "created": "2020-08-06T00:43:23",
    "hidden": false,
    "id": 40266,
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
    "address": "63003 Aisha Lock",
    "created": "2020-08-06T00:43:23",
    "hidden": false,
    "id": 40266,
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
  "restaurant_id": 40279
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted restaurant 'Maria’s Pasta and Pizza' with id 40279"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ restaurants:lobby
* __Event:__ restaurant_deleted
* __Body:__
```json
{
  "message": "Deleted restaurant 'Maria’s Pasta and Pizza'",
  "restaurant_id": 40279
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
  "restaurant_id": 40295
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "hidden": false,
    "id": 11797,
    "name": "test menu",
    "products": [],
    "restaurant_id": 40295
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
    "id": 11797,
    "name": "test menu",
    "products": [],
    "restaurant_id": 40295
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
  "menu_id": 11792,
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
    "id": 11792,
    "name": "some new name",
    "products": [],
    "restaurant_id": 40287
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
    "id": 11792,
    "name": "some new name",
    "products": [],
    "restaurant_id": 40287
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
  "menu_id": 11798
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted menu 'test menu1' with id 11798"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ restaurants:lobby
* __Event:__ menu_deleted
* __Body:__
```json
{
  "menu_id": 11798,
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
  "restaurant_id": 40260
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "address": "7 Shaun Motorway",
    "created": "2020-08-06T00:43:22",
    "hidden": false,
    "id": 40260,
    "menus": [
      {
        "hidden": false,
        "id": 11786,
        "name": "Veggie Korma",
        "products": [],
        "restaurant_id": 40260
      },
      {
        "hidden": false,
        "id": 11787,
        "name": "Bolognese",
        "products": [],
        "restaurant_id": 40260
      },
      {
        "hidden": false,
        "id": 11788,
        "name": "Mockba",
        "products": [],
        "restaurant_id": 40260
      },
      {
        "hidden": false,
        "id": 11789,
        "name": "Viennese",
        "products": [],
        "restaurant_id": 40260
      }
    ],
    "name": "Pete’s Pizza",
    "unlisted_products": [],
    "url": "https://petes-pizza.se"
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
  "menu_id": 11789,
  "restaurant_id": 40260
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
        "id": 11786,
        "name": "Veggie Korma",
        "products": [],
        "restaurant_id": 40260
      },
      {
        "hidden": false,
        "id": 11789,
        "name": "Viennese",
        "products": [],
        "restaurant_id": 40260
      },
      {
        "hidden": false,
        "id": 11787,
        "name": "Bolognese",
        "products": [],
        "restaurant_id": 40260
      },
      {
        "hidden": false,
        "id": 11788,
        "name": "Mockba",
        "products": [],
        "restaurant_id": 40260
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
  "menu_id": 11788,
  "restaurant_id": 40260
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
        "id": 11786,
        "name": "Veggie Korma",
        "products": [],
        "restaurant_id": 40260
      },
      {
        "hidden": false,
        "id": 11789,
        "name": "Viennese",
        "products": [],
        "restaurant_id": 40260
      },
      {
        "hidden": false,
        "id": 11788,
        "name": "Mockba",
        "products": [],
        "restaurant_id": 40260
      },
      {
        "hidden": false,
        "id": 11787,
        "name": "Bolognese",
        "products": [],
        "restaurant_id": 40260
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
  "menu_id": 11786,
  "restaurant_id": 40260
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
        "id": 11789,
        "name": "Viennese",
        "products": [],
        "restaurant_id": 40260
      },
      {
        "hidden": false,
        "id": 11786,
        "name": "Veggie Korma",
        "products": [],
        "restaurant_id": 40260
      },
      {
        "hidden": false,
        "id": 11788,
        "name": "Mockba",
        "products": [],
        "restaurant_id": 40260
      },
      {
        "hidden": false,
        "id": 11787,
        "name": "Bolognese",
        "products": [],
        "restaurant_id": 40260
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
  "menu_id": 11788,
  "restaurant_id": 40260
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
        "id": 11788,
        "name": "Mockba",
        "products": [],
        "restaurant_id": 40260
      },
      {
        "hidden": false,
        "id": 11789,
        "name": "Viennese",
        "products": [],
        "restaurant_id": 40260
      },
      {
        "hidden": false,
        "id": 11786,
        "name": "Veggie Korma",
        "products": [],
        "restaurant_id": 40260
      },
      {
        "hidden": false,
        "id": 11787,
        "name": "Bolognese",
        "products": [],
        "restaurant_id": 40260
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
  "menu_id": 11789,
  "restaurant_id": 40260
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
        "id": 11788,
        "name": "Mockba",
        "products": [],
        "restaurant_id": 40260
      },
      {
        "hidden": false,
        "id": 11786,
        "name": "Veggie Korma",
        "products": [],
        "restaurant_id": 40260
      },
      {
        "hidden": false,
        "id": 11787,
        "name": "Bolognese",
        "products": [],
        "restaurant_id": 40260
      },
      {
        "hidden": false,
        "id": 11789,
        "name": "Viennese",
        "products": [],
        "restaurant_id": 40260
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
  "user_id": 50402
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
  "menu_id": 11769
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
        "id": 5416,
        "inserted_at": "2020-08-06T00:43:21",
        "menu_id": 11769,
        "name": "12\" with Green Peppers, Black Olives, and Mutton",
        "price": {
          "amount": 8640,
          "currency": "SEK"
        },
        "price_to_string": "86,40:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5417,
        "inserted_at": "2020-08-06T00:43:21",
        "menu_id": 11769,
        "name": "10\" Kebab",
        "price": {
          "amount": 7544,
          "currency": "SEK"
        },
        "price_to_string": "75,44:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5418,
        "inserted_at": "2020-08-06T00:43:21",
        "menu_id": 11769,
        "name": "16\" Sweet Potato Crust Pesto Chicken",
        "price": {
          "amount": 7740,
          "currency": "SEK"
        },
        "price_to_string": "77,40:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5419,
        "inserted_at": "2020-08-06T00:43:21",
        "menu_id": 11769,
        "name": "Medium with Philly Steak, Pulled Pork, Chili Sauce, Anchovies, and Hamburger",
        "price": {
          "amount": 9809,
          "currency": "SEK"
        },
        "price_to_string": "98,09:-",
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
  "menu_id": 11770,
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
    "id": 5420,
    "inserted_at": "2020-08-06T00:43:21",
    "menu_id": 11770,
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
    "id": 5420,
    "inserted_at": "2020-08-06T00:43:21",
    "menu_id": 11770,
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
  "restaurant_id": 40243
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "hidden": true,
    "id": 5433,
    "inserted_at": "2020-08-06T00:43:22",
    "menu_id": null,
    "name": "test product 29",
    "price": {
      "amount": 2900,
      "currency": "SEK"
    },
    "price_to_string": "29:-",
    "product_extra_menus": [],
    "restaurant_id": 40243
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
  "product_id": 5432
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "hidden": true,
    "id": 5432,
    "inserted_at": "2020-08-06T00:43:22",
    "menu_id": 11778,
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
    "id": 5432,
    "inserted_at": "2020-08-06T00:43:22",
    "menu_id": 11778,
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
  "product_id": 5437
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted product 'Family Sweet Potato Crust with Venison, Coconut, and Shellfish' with id 5437"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ merchandise:lobby
* __Event:__ product_deleted
* __Body:__
```json
{
  "message": "Deleted product 'Family Sweet Potato Crust with Venison, Coconut, and Shellfish'",
  "product_id": 5437
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
  "menu_id": 11777
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
        "id": 5428,
        "inserted_at": "2020-08-06T00:43:22",
        "menu_id": 11777,
        "name": "20\" Pepperoni & Mushroom",
        "price": {
          "amount": 9150,
          "currency": "SEK"
        },
        "price_to_string": "91,50:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5429,
        "inserted_at": "2020-08-06T00:43:22",
        "menu_id": 11777,
        "name": "Large Meat Feast",
        "price": {
          "amount": 7275,
          "currency": "SEK"
        },
        "price_to_string": "72,75:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5430,
        "inserted_at": "2020-08-06T00:43:22",
        "menu_id": 11777,
        "name": "20\" Italian Deli",
        "price": {
          "amount": 9003,
          "currency": "SEK"
        },
        "price_to_string": "90,03:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5431,
        "inserted_at": "2020-08-06T00:43:22",
        "menu_id": 11777,
        "name": "11\" Hand Tossed with Emmental, Capicola, Eel, Salsa, and Broccoli",
        "price": {
          "amount": 8159,
          "currency": "SEK"
        },
        "price_to_string": "81,59:-",
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
  "menu_id": 11777,
  "product_id": 5431
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
        "id": 5428,
        "inserted_at": "2020-08-06T00:43:22",
        "menu_id": 11777,
        "name": "20\" Pepperoni & Mushroom",
        "price": {
          "amount": 9150,
          "currency": "SEK"
        },
        "price_to_string": "91,50:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5431,
        "inserted_at": "2020-08-06T00:43:22",
        "menu_id": 11777,
        "name": "11\" Hand Tossed with Emmental, Capicola, Eel, Salsa, and Broccoli",
        "price": {
          "amount": 8159,
          "currency": "SEK"
        },
        "price_to_string": "81,59:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5429,
        "inserted_at": "2020-08-06T00:43:22",
        "menu_id": 11777,
        "name": "Large Meat Feast",
        "price": {
          "amount": 7275,
          "currency": "SEK"
        },
        "price_to_string": "72,75:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5430,
        "inserted_at": "2020-08-06T00:43:22",
        "menu_id": 11777,
        "name": "20\" Italian Deli",
        "price": {
          "amount": 9003,
          "currency": "SEK"
        },
        "price_to_string": "90,03:-",
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
  "menu_id": 11777,
  "product_id": 5430
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
        "id": 5428,
        "inserted_at": "2020-08-06T00:43:22",
        "menu_id": 11777,
        "name": "20\" Pepperoni & Mushroom",
        "price": {
          "amount": 9150,
          "currency": "SEK"
        },
        "price_to_string": "91,50:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5431,
        "inserted_at": "2020-08-06T00:43:22",
        "menu_id": 11777,
        "name": "11\" Hand Tossed with Emmental, Capicola, Eel, Salsa, and Broccoli",
        "price": {
          "amount": 8159,
          "currency": "SEK"
        },
        "price_to_string": "81,59:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5430,
        "inserted_at": "2020-08-06T00:43:22",
        "menu_id": 11777,
        "name": "20\" Italian Deli",
        "price": {
          "amount": 9003,
          "currency": "SEK"
        },
        "price_to_string": "90,03:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5429,
        "inserted_at": "2020-08-06T00:43:22",
        "menu_id": 11777,
        "name": "Large Meat Feast",
        "price": {
          "amount": 7275,
          "currency": "SEK"
        },
        "price_to_string": "72,75:-",
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
  "menu_id": 11777,
  "product_id": 5428
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
        "id": 5431,
        "inserted_at": "2020-08-06T00:43:22",
        "menu_id": 11777,
        "name": "11\" Hand Tossed with Emmental, Capicola, Eel, Salsa, and Broccoli",
        "price": {
          "amount": 8159,
          "currency": "SEK"
        },
        "price_to_string": "81,59:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5428,
        "inserted_at": "2020-08-06T00:43:22",
        "menu_id": 11777,
        "name": "20\" Pepperoni & Mushroom",
        "price": {
          "amount": 9150,
          "currency": "SEK"
        },
        "price_to_string": "91,50:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5430,
        "inserted_at": "2020-08-06T00:43:22",
        "menu_id": 11777,
        "name": "20\" Italian Deli",
        "price": {
          "amount": 9003,
          "currency": "SEK"
        },
        "price_to_string": "90,03:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5429,
        "inserted_at": "2020-08-06T00:43:22",
        "menu_id": 11777,
        "name": "Large Meat Feast",
        "price": {
          "amount": 7275,
          "currency": "SEK"
        },
        "price_to_string": "72,75:-",
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
  "menu_id": 11777,
  "product_id": 5430
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
        "id": 5430,
        "inserted_at": "2020-08-06T00:43:22",
        "menu_id": 11777,
        "name": "20\" Italian Deli",
        "price": {
          "amount": 9003,
          "currency": "SEK"
        },
        "price_to_string": "90,03:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5431,
        "inserted_at": "2020-08-06T00:43:22",
        "menu_id": 11777,
        "name": "11\" Hand Tossed with Emmental, Capicola, Eel, Salsa, and Broccoli",
        "price": {
          "amount": 8159,
          "currency": "SEK"
        },
        "price_to_string": "81,59:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5428,
        "inserted_at": "2020-08-06T00:43:22",
        "menu_id": 11777,
        "name": "20\" Pepperoni & Mushroom",
        "price": {
          "amount": 9150,
          "currency": "SEK"
        },
        "price_to_string": "91,50:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5429,
        "inserted_at": "2020-08-06T00:43:22",
        "menu_id": 11777,
        "name": "Large Meat Feast",
        "price": {
          "amount": 7275,
          "currency": "SEK"
        },
        "price_to_string": "72,75:-",
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
  "menu_id": 11777,
  "product_id": 5431
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
        "id": 5430,
        "inserted_at": "2020-08-06T00:43:22",
        "menu_id": 11777,
        "name": "20\" Italian Deli",
        "price": {
          "amount": 9003,
          "currency": "SEK"
        },
        "price_to_string": "90,03:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5428,
        "inserted_at": "2020-08-06T00:43:22",
        "menu_id": 11777,
        "name": "20\" Pepperoni & Mushroom",
        "price": {
          "amount": 9150,
          "currency": "SEK"
        },
        "price_to_string": "91,50:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5429,
        "inserted_at": "2020-08-06T00:43:22",
        "menu_id": 11777,
        "name": "Large Meat Feast",
        "price": {
          "amount": 7275,
          "currency": "SEK"
        },
        "price_to_string": "72,75:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": true,
        "id": 5431,
        "inserted_at": "2020-08-06T00:43:22",
        "menu_id": 11777,
        "name": "11\" Hand Tossed with Emmental, Capicola, Eel, Salsa, and Broccoli",
        "price": {
          "amount": 8159,
          "currency": "SEK"
        },
        "price_to_string": "81,59:-",
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
  "hidden": false,
  "name": "Sauces",
  "product_id": 5434
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "default_extra": null,
    "hidden": true,
    "id": 847,
    "inserted_at": "2020-08-06T00:43:22",
    "mandatory": false,
    "name": "Sauces",
    "pick_only_one": false,
    "product_extras": [],
    "product_id": 5434
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
    "hidden": true,
    "id": 847,
    "inserted_at": "2020-08-06T00:43:22",
    "mandatory": false,
    "name": "Sauces",
    "pick_only_one": false,
    "product_extras": [],
    "product_id": 5434
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
  "product_extra_menu_id": 849
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
    "id": 849,
    "inserted_at": "2020-08-06T00:43:22",
    "mandatory": true,
    "name": "Must Pick One Sauce",
    "pick_only_one": true,
    "product_extras": [],
    "product_id": 5438
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
    "id": 849,
    "inserted_at": "2020-08-06T00:43:22",
    "mandatory": true,
    "name": "Must Pick One Sauce",
    "pick_only_one": true,
    "product_extras": [],
    "product_id": 5438
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
  "product_extra_menu_id": 844
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted product extra menu: 'Sauces' with id 844"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ merchandise:lobby
* __Event:__ product_extra_menu_deleted
* __Body:__
```json
{
  "message": "Deleted product extra menu: 'Sauces'",
  "product_extra_menu_id": 844
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
  "new_name": "Salsa",
  "new_price": 1000,
  "product_extra_menu_id": 848,
  "product_id": 5436
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "hidden": false,
    "id": 612,
    "inserted_at": "2020-08-06T00:43:22",
    "new_name": "Salsa",
    "new_price": {
      "amount": 1000,
      "currency": "SEK"
    },
    "new_price_to_string": "10:-",
    "product": {
      "hidden": false,
      "id": 5436,
      "inserted_at": "2020-08-06T00:43:22",
      "menu_id": null,
      "name": "Salsa",
      "price": {
        "amount": 3243,
        "currency": "SEK"
      },
      "price_to_string": "32,43:-",
      "restaurant_id": 40245
    },
    "product_extra_menu_id": 848,
    "product_id": 5436
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
    "id": 612,
    "inserted_at": "2020-08-06T00:43:22",
    "new_name": "Salsa",
    "new_price": {
      "amount": 1000,
      "currency": "SEK"
    },
    "new_price_to_string": "10:-",
    "product": {
      "hidden": false,
      "id": 5436,
      "inserted_at": "2020-08-06T00:43:22",
      "menu_id": null,
      "name": "Salsa",
      "price": {
        "amount": 3243,
        "currency": "SEK"
      },
      "price_to_string": "32,43:-",
      "restaurant_id": 40245
    },
    "product_extra_menu_id": 848,
    "product_id": 5436
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
  "product_extra_id": 611
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "hidden": false,
    "id": 611,
    "inserted_at": "2020-08-06T00:43:22",
    "new_name": "Sauce X",
    "new_price": {
      "amount": 900,
      "currency": "SEK"
    },
    "new_price_to_string": "9:-",
    "product": {
      "hidden": false,
      "id": 5427,
      "inserted_at": "2020-08-06T00:43:22",
      "menu_id": null,
      "name": "Chili Sauce",
      "price": {
        "amount": 4961,
        "currency": "SEK"
      },
      "price_to_string": "49,61:-",
      "restaurant_id": 40238
    },
    "product_extra_menu_id": 846,
    "product_id": 5427
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
    "id": 611,
    "inserted_at": "2020-08-06T00:43:22",
    "new_name": "Sauce X",
    "new_price": {
      "amount": 900,
      "currency": "SEK"
    },
    "new_price_to_string": "9:-",
    "product": {
      "hidden": false,
      "id": 5427,
      "inserted_at": "2020-08-06T00:43:22",
      "menu_id": null,
      "name": "Chili Sauce",
      "price": {
        "amount": 4961,
        "currency": "SEK"
      },
      "price_to_string": "49,61:-",
      "restaurant_id": 40238
    },
    "product_extra_menu_id": 846,
    "product_id": 5427
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
  "product_extra_id": 610
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted product extra: 'Sauce Y' with id 610"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ merchandise:lobby
* __Event:__ product_extra_deleted
* __Body:__
```json
{
  "message": "Deleted product extra: 'Sauce Y'",
  "product_extra_id": 610
}
```
---
