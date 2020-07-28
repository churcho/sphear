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
  "email": "user-576460752303423097@example.com",
  "password": "hello world!"
}
```

##### ← <ins>Response to you</ins>
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FiXTVFmPg4DOkysAAAdh
```
* __Response body:__
```json
{
  "success": {
    "token": "A+zoTrVRapoDsuGtogeD2wusKIey5rV7qnVZFNnk4HE="
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
  "email": "user-576460752303422910@example.com",
  "password": "lol"
}
```

##### ← <ins>Response to you</ins>
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FiXTVEYCoYC1_LcAAAIF
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
  "email": "user-576460752303422939@example.com",
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
x-request-id: FiXTVFiqocBeTHsAAAJF
```
* __Response body:__
```json
{
  "success": {
    "email": "user-576460752303422939@example.com",
    "token": "giMrzWnYGdEgO8F4uoihr6SjDnCSQCX7P+4ig8IULMM="
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
x-request-id: FiXTVEYCoYBfUTwAAAHl
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
  "user_id": 49016
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
        "address": "610 Mante Trafficway",
        "created": "2020-07-28T05:26:47",
        "id": 38587,
        "menus": [],
        "name": "Pizza Clown",
        "unlisted_products": [],
        "url": "https://pizza-clown.se"
      },
      {
        "address": "0617 Bashirian Brook",
        "created": "2020-07-28T05:26:47",
        "id": 38588,
        "menus": [],
        "name": "Pizza Potamus",
        "unlisted_products": [],
        "url": "https://pizza-potamus.se"
      },
      {
        "address": "9 Beer Parks",
        "created": "2020-07-28T05:26:47",
        "id": 38589,
        "menus": [],
        "name": "The Pizza Hole",
        "unlisted_products": [],
        "url": "https://the-pizza-hole.se"
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
  "restaurant_id": 38561
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "address": "3 Dorothea Dam",
    "created": "2020-07-28T05:26:46",
    "id": 38561,
    "menus": [
      {
        "id": 10915,
        "name": "Perogie",
        "products": [
          {
            "hidden": false,
            "id": 4661,
            "inserted_at": "2020-07-28T05:26:46",
            "menu_id": 10915,
            "name": "Medium Bolognese",
            "price": {
              "amount": 9019,
              "currency": "SEK"
            },
            "price_to_string": "90,19:-",
            "product_extra_menus": [
              {
                "default_extra": null,
                "id": 597,
                "inserted_at": "2020-07-28T05:26:46",
                "mandatory": false,
                "name": "Sauces",
                "pick_only_one": false,
                "product_extras": [
                  {
                    "hidden": false,
                    "id": 443,
                    "inserted_at": "2020-07-28T05:26:46",
                    "new_name": "Siracha Sauce",
                    "new_price": {
                      "amount": 1308,
                      "currency": "SEK"
                    },
                    "new_price_to_string": "13,08:-",
                    "product": {
                      "hidden": false,
                      "id": 4668,
                      "inserted_at": "2020-07-28T05:26:46",
                      "menu_id": null,
                      "name": "Soy Miso Sauce",
                      "price": {
                        "amount": 2355,
                        "currency": "SEK"
                      },
                      "price_to_string": "23,55:-",
                      "restaurant_id": 38565
                    },
                    "product_extra_menu_id": 597,
                    "product_id": 4668
                  },
                  {
                    "hidden": false,
                    "id": 442,
                    "inserted_at": "2020-07-28T05:26:46",
                    "new_name": "Butter Chicken Sauce",
                    "new_price": {
                      "amount": 2855,
                      "currency": "SEK"
                    },
                    "new_price_to_string": "28,55:-",
                    "product": {
                      "hidden": false,
                      "id": 4667,
                      "inserted_at": "2020-07-28T05:26:46",
                      "menu_id": null,
                      "name": "Gravy",
                      "price": {
                        "amount": 1280,
                        "currency": "SEK"
                      },
                      "price_to_string": "12,80:-",
                      "restaurant_id": 38564
                    },
                    "product_extra_menu_id": 597,
                    "product_id": 4667
                  },
                  {
                    "hidden": false,
                    "id": 441,
                    "inserted_at": "2020-07-28T05:26:46",
                    "new_name": "Chipolte Sauce",
                    "new_price": {
                      "amount": 2722,
                      "currency": "SEK"
                    },
                    "new_price_to_string": "27,22:-",
                    "product": {
                      "hidden": false,
                      "id": 4666,
                      "inserted_at": "2020-07-28T05:26:46",
                      "menu_id": null,
                      "name": "Salsa",
                      "price": {
                        "amount": 1542,
                        "currency": "SEK"
                      },
                      "price_to_string": "15,42:-",
                      "restaurant_id": 38563
                    },
                    "product_extra_menu_id": 597,
                    "product_id": 4666
                  },
                  {
                    "hidden": false,
                    "id": 440,
                    "inserted_at": "2020-07-28T05:26:46",
                    "new_name": "Chili Sauce",
                    "new_price": {
                      "amount": 2329,
                      "currency": "SEK"
                    },
                    "new_price_to_string": "23,29:-",
                    "product": {
                      "hidden": false,
                      "id": 4665,
                      "inserted_at": "2020-07-28T05:26:46",
                      "menu_id": null,
                      "name": "Siracha Sauce",
                      "price": {
                        "amount": 2405,
                        "currency": "SEK"
                      },
                      "price_to_string": "24,05:-",
                      "restaurant_id": 38562
                    },
                    "product_extra_menu_id": 597,
                    "product_id": 4665
                  }
                ],
                "product_id": 4661
              }
            ],
            "restaurant_id": null
          },
          {
            "hidden": false,
            "id": 4662,
            "inserted_at": "2020-07-28T05:26:46",
            "menu_id": 10915,
            "name": "30\" Meat Feast",
            "price": {
              "amount": 7776,
              "currency": "SEK"
            },
            "price_to_string": "77,76:-",
            "product_extra_menus": [],
            "restaurant_id": null
          },
          {
            "hidden": false,
            "id": 4663,
            "inserted_at": "2020-07-28T05:26:46",
            "menu_id": 10915,
            "name": "Large Wood Fired Ciao-ciao",
            "price": {
              "amount": 9638,
              "currency": "SEK"
            },
            "price_to_string": "96,38:-",
            "product_extra_menus": [],
            "restaurant_id": null
          },
          {
            "hidden": false,
            "id": 4664,
            "inserted_at": "2020-07-28T05:26:46",
            "menu_id": 10915,
            "name": "Small Meat Feast",
            "price": {
              "amount": 9994,
              "currency": "SEK"
            },
            "price_to_string": "99,94:-",
            "product_extra_menus": [],
            "restaurant_id": null
          }
        ],
        "restaurant_id": 38561
      }
    ],
    "name": "Maria’s Pasta and Pizza",
    "unlisted_products": [],
    "url": "https://marias-pasta-and-pizza.se"
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
  "restaurant_id": 38600
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
        "id": 10925,
        "name": "Mockba",
        "products": [],
        "restaurant_id": 38600
      },
      {
        "id": 10926,
        "name": "Shrimp Club",
        "products": [],
        "restaurant_id": 38600
      },
      {
        "id": 10927,
        "name": "Capricciosa ",
        "products": [],
        "restaurant_id": 38600
      },
      {
        "id": 10928,
        "name": "Kebab",
        "products": [],
        "restaurant_id": 38600
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
  "menu_id": 10914
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "id": 10914,
    "name": "Maltija",
    "products": [],
    "restaurant_id": 38557
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
    "created": "2020-07-28T05:26:46",
    "id": 38559,
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
    "created": "2020-07-28T05:26:46",
    "id": 38559,
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
  "restaurant_id": 38595
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "address": "03669 Sporer Fork",
    "created": "2020-07-28T05:26:47",
    "id": 38595,
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
    "address": "03669 Sporer Fork",
    "created": "2020-07-28T05:26:47",
    "id": 38595,
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
  "restaurant_id": 38605
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted restaurant 'Pizza De Roma' with id 38605"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ restaurants:lobby
* __Event:__ restaurant_deleted
* __Body:__
```json
{
  "message": "Deleted restaurant 'Pizza De Roma'",
  "restaurant_id": 38605
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
  "restaurant_id": 38583
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "id": 10919,
    "name": "test menu",
    "products": [],
    "restaurant_id": 38583
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
    "id": 10919,
    "name": "test menu",
    "products": [],
    "restaurant_id": 38583
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
  "menu_id": 10918,
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
    "id": 10918,
    "name": "some new name",
    "products": [],
    "restaurant_id": 38581
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
    "id": 10918,
    "name": "some new name",
    "products": [],
    "restaurant_id": 38581
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
  "menu_id": 10916
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted menu 'test menu1' with id 10916"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ restaurants:lobby
* __Event:__ menu_deleted
* __Body:__
```json
{
  "menu_id": 10916,
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
  "restaurant_id": 38591
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "address": "44884 Doyle Pines",
    "created": "2020-07-28T05:26:47",
    "id": 38591,
    "menus": [
      {
        "id": 10921,
        "name": "Caprese",
        "products": [],
        "restaurant_id": 38591
      },
      {
        "id": 10922,
        "name": "Curry Banana",
        "products": [],
        "restaurant_id": 38591
      },
      {
        "id": 10923,
        "name": "Quattro Formaggi",
        "products": [],
        "restaurant_id": 38591
      },
      {
        "id": 10924,
        "name": "Thai Chicken",
        "products": [],
        "restaurant_id": 38591
      }
    ],
    "name": "Pizza Joe’s",
    "unlisted_products": [],
    "url": "https://pizza-joes.se"
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
  "menu_id": 10924,
  "restaurant_id": 38591
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
        "id": 10921,
        "name": "Caprese",
        "products": [],
        "restaurant_id": 38591
      },
      {
        "id": 10924,
        "name": "Thai Chicken",
        "products": [],
        "restaurant_id": 38591
      },
      {
        "id": 10922,
        "name": "Curry Banana",
        "products": [],
        "restaurant_id": 38591
      },
      {
        "id": 10923,
        "name": "Quattro Formaggi",
        "products": [],
        "restaurant_id": 38591
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
  "menu_id": 10923,
  "restaurant_id": 38591
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
        "id": 10921,
        "name": "Caprese",
        "products": [],
        "restaurant_id": 38591
      },
      {
        "id": 10924,
        "name": "Thai Chicken",
        "products": [],
        "restaurant_id": 38591
      },
      {
        "id": 10923,
        "name": "Quattro Formaggi",
        "products": [],
        "restaurant_id": 38591
      },
      {
        "id": 10922,
        "name": "Curry Banana",
        "products": [],
        "restaurant_id": 38591
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
  "menu_id": 10921,
  "restaurant_id": 38591
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
        "id": 10924,
        "name": "Thai Chicken",
        "products": [],
        "restaurant_id": 38591
      },
      {
        "id": 10921,
        "name": "Caprese",
        "products": [],
        "restaurant_id": 38591
      },
      {
        "id": 10923,
        "name": "Quattro Formaggi",
        "products": [],
        "restaurant_id": 38591
      },
      {
        "id": 10922,
        "name": "Curry Banana",
        "products": [],
        "restaurant_id": 38591
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
  "menu_id": 10923,
  "restaurant_id": 38591
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
        "id": 10923,
        "name": "Quattro Formaggi",
        "products": [],
        "restaurant_id": 38591
      },
      {
        "id": 10924,
        "name": "Thai Chicken",
        "products": [],
        "restaurant_id": 38591
      },
      {
        "id": 10921,
        "name": "Caprese",
        "products": [],
        "restaurant_id": 38591
      },
      {
        "id": 10922,
        "name": "Curry Banana",
        "products": [],
        "restaurant_id": 38591
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
  "menu_id": 10924,
  "restaurant_id": 38591
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
        "id": 10923,
        "name": "Quattro Formaggi",
        "products": [],
        "restaurant_id": 38591
      },
      {
        "id": 10921,
        "name": "Caprese",
        "products": [],
        "restaurant_id": 38591
      },
      {
        "id": 10922,
        "name": "Curry Banana",
        "products": [],
        "restaurant_id": 38591
      },
      {
        "id": 10924,
        "name": "Thai Chicken",
        "products": [],
        "restaurant_id": 38591
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
  "user_id": 49006
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
  "menu_id": 10902
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
        "id": 4642,
        "inserted_at": "2020-07-28T05:26:45",
        "menu_id": 10902,
        "name": "Medium with Meatballs, Sausage, Artichoke Hearts, Eel, and Shrimps",
        "price": {
          "amount": 7039,
          "currency": "SEK"
        },
        "price_to_string": "70,39:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 4643,
        "inserted_at": "2020-07-28T05:26:45",
        "menu_id": 10902,
        "name": "Large with Red Onion, Feta, and Steak",
        "price": {
          "amount": 7395,
          "currency": "SEK"
        },
        "price_to_string": "73,95:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 4644,
        "inserted_at": "2020-07-28T05:26:45",
        "menu_id": 10902,
        "name": "11\" Mockba",
        "price": {
          "amount": 9184,
          "currency": "SEK"
        },
        "price_to_string": "91,84:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 4645,
        "inserted_at": "2020-07-28T05:26:45",
        "menu_id": 10902,
        "name": "Small Stuffed Crust with Mustard, Hamburger, and Asiago",
        "price": {
          "amount": 8979,
          "currency": "SEK"
        },
        "price_to_string": "89,79:-",
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
  "menu_id": 10899,
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
    "id": 4638,
    "inserted_at": "2020-07-28T05:26:45",
    "menu_id": 10899,
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
    "id": 4638,
    "inserted_at": "2020-07-28T05:26:45",
    "menu_id": 10899,
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
  "restaurant_id": 38544
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "hidden": true,
    "id": 4648,
    "inserted_at": "2020-07-28T05:26:46",
    "menu_id": null,
    "name": "test product 29",
    "price": {
      "amount": 2900,
      "currency": "SEK"
    },
    "price_to_string": "29:-",
    "product_extra_menus": [],
    "restaurant_id": 38544
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
  "product_id": 4660
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "hidden": false,
    "id": 4660,
    "inserted_at": "2020-07-28T05:26:46",
    "menu_id": 10913,
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
    "id": 4660,
    "inserted_at": "2020-07-28T05:26:46",
    "menu_id": 10913,
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
  "product_id": 4653
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted product '10\" Meat Lovers' with id 4653"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ merchandise:lobby
* __Event:__ product_deleted
* __Body:__
```json
{
  "message": "Deleted product '10\" Meat Lovers'",
  "product_id": 4653
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
  "menu_id": 10910
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
        "id": 4656,
        "inserted_at": "2020-07-28T05:26:46",
        "menu_id": 10910,
        "name": "9\" with Fontina, Mackerel, and Squid",
        "price": {
          "amount": 8138,
          "currency": "SEK"
        },
        "price_to_string": "81,38:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 4657,
        "inserted_at": "2020-07-28T05:26:46",
        "menu_id": 10910,
        "name": "Extra-Large Pizza Frittata Capricciosa",
        "price": {
          "amount": 8551,
          "currency": "SEK"
        },
        "price_to_string": "85,51:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 4658,
        "inserted_at": "2020-07-28T05:26:46",
        "menu_id": 10910,
        "name": "Large Italian Deli",
        "price": {
          "amount": 8165,
          "currency": "SEK"
        },
        "price_to_string": "81,65:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 4659,
        "inserted_at": "2020-07-28T05:26:46",
        "menu_id": 10910,
        "name": "14\" Capricciosa",
        "price": {
          "amount": 7096,
          "currency": "SEK"
        },
        "price_to_string": "70,96:-",
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
  "menu_id": 10910,
  "product_id": 4659
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
        "id": 4656,
        "inserted_at": "2020-07-28T05:26:46",
        "menu_id": 10910,
        "name": "9\" with Fontina, Mackerel, and Squid",
        "price": {
          "amount": 8138,
          "currency": "SEK"
        },
        "price_to_string": "81,38:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 4659,
        "inserted_at": "2020-07-28T05:26:46",
        "menu_id": 10910,
        "name": "14\" Capricciosa",
        "price": {
          "amount": 7096,
          "currency": "SEK"
        },
        "price_to_string": "70,96:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 4657,
        "inserted_at": "2020-07-28T05:26:46",
        "menu_id": 10910,
        "name": "Extra-Large Pizza Frittata Capricciosa",
        "price": {
          "amount": 8551,
          "currency": "SEK"
        },
        "price_to_string": "85,51:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 4658,
        "inserted_at": "2020-07-28T05:26:46",
        "menu_id": 10910,
        "name": "Large Italian Deli",
        "price": {
          "amount": 8165,
          "currency": "SEK"
        },
        "price_to_string": "81,65:-",
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
  "menu_id": 10910,
  "product_id": 4658
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
        "id": 4656,
        "inserted_at": "2020-07-28T05:26:46",
        "menu_id": 10910,
        "name": "9\" with Fontina, Mackerel, and Squid",
        "price": {
          "amount": 8138,
          "currency": "SEK"
        },
        "price_to_string": "81,38:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 4659,
        "inserted_at": "2020-07-28T05:26:46",
        "menu_id": 10910,
        "name": "14\" Capricciosa",
        "price": {
          "amount": 7096,
          "currency": "SEK"
        },
        "price_to_string": "70,96:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 4658,
        "inserted_at": "2020-07-28T05:26:46",
        "menu_id": 10910,
        "name": "Large Italian Deli",
        "price": {
          "amount": 8165,
          "currency": "SEK"
        },
        "price_to_string": "81,65:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 4657,
        "inserted_at": "2020-07-28T05:26:46",
        "menu_id": 10910,
        "name": "Extra-Large Pizza Frittata Capricciosa",
        "price": {
          "amount": 8551,
          "currency": "SEK"
        },
        "price_to_string": "85,51:-",
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
  "menu_id": 10910,
  "product_id": 4656
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
        "id": 4659,
        "inserted_at": "2020-07-28T05:26:46",
        "menu_id": 10910,
        "name": "14\" Capricciosa",
        "price": {
          "amount": 7096,
          "currency": "SEK"
        },
        "price_to_string": "70,96:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 4656,
        "inserted_at": "2020-07-28T05:26:46",
        "menu_id": 10910,
        "name": "9\" with Fontina, Mackerel, and Squid",
        "price": {
          "amount": 8138,
          "currency": "SEK"
        },
        "price_to_string": "81,38:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 4658,
        "inserted_at": "2020-07-28T05:26:46",
        "menu_id": 10910,
        "name": "Large Italian Deli",
        "price": {
          "amount": 8165,
          "currency": "SEK"
        },
        "price_to_string": "81,65:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 4657,
        "inserted_at": "2020-07-28T05:26:46",
        "menu_id": 10910,
        "name": "Extra-Large Pizza Frittata Capricciosa",
        "price": {
          "amount": 8551,
          "currency": "SEK"
        },
        "price_to_string": "85,51:-",
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
  "menu_id": 10910,
  "product_id": 4658
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
        "id": 4658,
        "inserted_at": "2020-07-28T05:26:46",
        "menu_id": 10910,
        "name": "Large Italian Deli",
        "price": {
          "amount": 8165,
          "currency": "SEK"
        },
        "price_to_string": "81,65:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 4659,
        "inserted_at": "2020-07-28T05:26:46",
        "menu_id": 10910,
        "name": "14\" Capricciosa",
        "price": {
          "amount": 7096,
          "currency": "SEK"
        },
        "price_to_string": "70,96:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 4656,
        "inserted_at": "2020-07-28T05:26:46",
        "menu_id": 10910,
        "name": "9\" with Fontina, Mackerel, and Squid",
        "price": {
          "amount": 8138,
          "currency": "SEK"
        },
        "price_to_string": "81,38:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 4657,
        "inserted_at": "2020-07-28T05:26:46",
        "menu_id": 10910,
        "name": "Extra-Large Pizza Frittata Capricciosa",
        "price": {
          "amount": 8551,
          "currency": "SEK"
        },
        "price_to_string": "85,51:-",
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
  "menu_id": 10910,
  "product_id": 4659
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
        "id": 4658,
        "inserted_at": "2020-07-28T05:26:46",
        "menu_id": 10910,
        "name": "Large Italian Deli",
        "price": {
          "amount": 8165,
          "currency": "SEK"
        },
        "price_to_string": "81,65:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 4656,
        "inserted_at": "2020-07-28T05:26:46",
        "menu_id": 10910,
        "name": "9\" with Fontina, Mackerel, and Squid",
        "price": {
          "amount": 8138,
          "currency": "SEK"
        },
        "price_to_string": "81,38:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 4657,
        "inserted_at": "2020-07-28T05:26:46",
        "menu_id": 10910,
        "name": "Extra-Large Pizza Frittata Capricciosa",
        "price": {
          "amount": 8551,
          "currency": "SEK"
        },
        "price_to_string": "85,51:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 4659,
        "inserted_at": "2020-07-28T05:26:46",
        "menu_id": 10910,
        "name": "14\" Capricciosa",
        "price": {
          "amount": 7096,
          "currency": "SEK"
        },
        "price_to_string": "70,96:-",
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
  "product_id": 4652
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "default_extra": null,
    "id": 595,
    "inserted_at": "2020-07-28T05:26:46",
    "mandatory": false,
    "name": "Sauces",
    "pick_only_one": false,
    "product_extras": [],
    "product_id": 4652
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
    "id": 595,
    "inserted_at": "2020-07-28T05:26:46",
    "mandatory": false,
    "name": "Sauces",
    "pick_only_one": false,
    "product_extras": [],
    "product_id": 4652
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
    "name": "New Sauces",
    "pick_only_one": true
  },
  "product_extra_menu_id": 592
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "default_extra": null,
    "id": 592,
    "inserted_at": "2020-07-28T05:26:45",
    "mandatory": true,
    "name": "New Sauces",
    "pick_only_one": true,
    "product_extras": [],
    "product_id": 4641
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
    "id": 592,
    "inserted_at": "2020-07-28T05:26:45",
    "mandatory": true,
    "name": "New Sauces",
    "pick_only_one": true,
    "product_extras": [],
    "product_id": 4641
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
  "product_extra_menu_id": 596
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted product extra menu: 'Sauces' with id 596"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ merchandise:lobby
* __Event:__ product_extra_menu_deleted
* __Body:__
```json
{
  "message": "Deleted product extra menu: 'Sauces'",
  "product_extra_menu_id": 596
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
  "new_name": "Hoisin Sauce",
  "new_price": 1000,
  "product_extra_menu_id": 591,
  "product_id": 4640
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "hidden": false,
    "id": 437,
    "inserted_at": "2020-07-28T05:26:45",
    "new_name": "Hoisin Sauce",
    "new_price": {
      "amount": 1000,
      "currency": "SEK"
    },
    "new_price_to_string": "10:-",
    "product": {
      "hidden": false,
      "id": 4640,
      "inserted_at": "2020-07-28T05:26:45",
      "menu_id": null,
      "name": "Hoisin Sauce",
      "price": {
        "amount": 1137,
        "currency": "SEK"
      },
      "price_to_string": "11,37:-",
      "restaurant_id": 38539
    },
    "product_extra_menu_id": 591,
    "product_id": 4640
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
    "id": 437,
    "inserted_at": "2020-07-28T05:26:45",
    "new_name": "Hoisin Sauce",
    "new_price": {
      "amount": 1000,
      "currency": "SEK"
    },
    "new_price_to_string": "10:-",
    "product": {
      "hidden": false,
      "id": 4640,
      "inserted_at": "2020-07-28T05:26:45",
      "menu_id": null,
      "name": "Hoisin Sauce",
      "price": {
        "amount": 1137,
        "currency": "SEK"
      },
      "price_to_string": "11,37:-",
      "restaurant_id": 38539
    },
    "product_extra_menu_id": 591,
    "product_id": 4640
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
  "product_extra_id": 439
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "hidden": false,
    "id": 439,
    "inserted_at": "2020-07-28T05:26:46",
    "new_name": "Sauce X",
    "new_price": {
      "amount": 900,
      "currency": "SEK"
    },
    "new_price_to_string": "9:-",
    "product": {
      "hidden": false,
      "id": 4650,
      "inserted_at": "2020-07-28T05:26:46",
      "menu_id": null,
      "name": "Mustard",
      "price": {
        "amount": 2895,
        "currency": "SEK"
      },
      "price_to_string": "28,95:-",
      "restaurant_id": 38545
    },
    "product_extra_menu_id": 594,
    "product_id": 4650
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
    "id": 439,
    "inserted_at": "2020-07-28T05:26:46",
    "new_name": "Sauce X",
    "new_price": {
      "amount": 900,
      "currency": "SEK"
    },
    "new_price_to_string": "9:-",
    "product": {
      "hidden": false,
      "id": 4650,
      "inserted_at": "2020-07-28T05:26:46",
      "menu_id": null,
      "name": "Mustard",
      "price": {
        "amount": 2895,
        "currency": "SEK"
      },
      "price_to_string": "28,95:-",
      "restaurant_id": 38545
    },
    "product_extra_menu_id": 594,
    "product_id": 4650
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
  "product_extra_id": 438
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted product extra: 'Sauce Y' with id 438"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ merchandise:lobby
* __Event:__ product_extra_deleted
* __Body:__
```json
{
  "message": "Deleted product extra: 'Sauce Y'",
  "product_extra_id": 438
}
```
---
