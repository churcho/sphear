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
  "email": "user-576460752303423133@example.com",
  "password": "hello world!"
}
```

##### ← <ins>Response to you</ins>
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FiYFIXCBSEDboFEAAAGD
```
* __Response body:__
```json
{
  "success": {
    "token": "Dj+8+e/6Ds1tI+wOq1Dj3NAuI72zCHtF3s3T9VE/5/E="
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
  "email": "user-576460752303421439@example.com",
  "password": "lol"
}
```

##### ← <ins>Response to you</ins>
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FiYFIWzPPMC2oD4AAAFD
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
  "email": "user-576460752303422843@example.com",
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
x-request-id: FiYFIXCBSEC5Vm0AAAKl
```
* __Response body:__
```json
{
  "success": {
    "email": "user-576460752303422843@example.com",
    "token": "hIfia9XM+UJRLPKUPiaL9mGzo54xJoYo6U/XK61N9Fs="
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
x-request-id: FiYFIWzPPMAGmfwAAAEj
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
  "user_id": 49919
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
        "address": "9 Frami Freeway",
        "created": "2020-07-28T20:39:22",
        "id": 39670,
        "menus": [],
        "name": "Mystic Pizza",
        "unlisted_products": [],
        "url": "https://mystic-pizza.se"
      },
      {
        "address": "46 Vandervort Locks",
        "created": "2020-07-28T20:39:22",
        "id": 39671,
        "menus": [],
        "name": "California Style Pizzas",
        "unlisted_products": [],
        "url": "https://california-style-pizzas.se"
      },
      {
        "address": "172 Maxwell Estate",
        "created": "2020-07-28T20:39:22",
        "id": 39672,
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
  "restaurant_id": 39636
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "address": "6 Goyette Curve",
    "created": "2020-07-28T20:39:21",
    "id": 39636,
    "menus": [
      {
        "id": 11469,
        "name": "BBQ Chicken",
        "products": [
          {
            "hidden": false,
            "id": 5159,
            "inserted_at": "2020-07-28T20:39:21",
            "menu_id": 11469,
            "name": "11\" Smoked Salmon & Goat Cheese",
            "price": {
              "amount": 8087,
              "currency": "SEK"
            },
            "price_to_string": "80,87:-",
            "product_extra_menus": [
              {
                "default_extra": null,
                "id": 759,
                "inserted_at": "2020-07-28T20:39:21",
                "mandatory": false,
                "name": "Sauces",
                "pick_only_one": false,
                "product_extras": [
                  {
                    "hidden": false,
                    "id": 553,
                    "inserted_at": "2020-07-28T20:39:21",
                    "new_name": "Huge Pommes",
                    "new_price": {
                      "amount": 6962,
                      "currency": "SEK"
                    },
                    "new_price_to_string": "69,62:-",
                    "product": {
                      "hidden": false,
                      "id": 5163,
                      "inserted_at": "2020-07-28T20:39:21",
                      "menu_id": null,
                      "name": "Pommes",
                      "price": {
                        "amount": 3883,
                        "currency": "SEK"
                      },
                      "price_to_string": "38,83:-",
                      "restaurant_id": 39636
                    },
                    "product_extra_menu_id": 759,
                    "product_id": 5163
                  },
                  {
                    "hidden": false,
                    "id": 552,
                    "inserted_at": "2020-07-28T20:39:21",
                    "new_name": "Big Pommes",
                    "new_price": {
                      "amount": 5985,
                      "currency": "SEK"
                    },
                    "new_price_to_string": "59,85:-",
                    "product": {
                      "hidden": false,
                      "id": 5163,
                      "inserted_at": "2020-07-28T20:39:21",
                      "menu_id": null,
                      "name": "Pommes",
                      "price": {
                        "amount": 3883,
                        "currency": "SEK"
                      },
                      "price_to_string": "38,83:-",
                      "restaurant_id": 39636
                    },
                    "product_extra_menu_id": 759,
                    "product_id": 5163
                  },
                  {
                    "hidden": false,
                    "id": 551,
                    "inserted_at": "2020-07-28T20:39:21",
                    "new_name": "Medium Pommes",
                    "new_price": {
                      "amount": 3228,
                      "currency": "SEK"
                    },
                    "new_price_to_string": "32,28:-",
                    "product": {
                      "hidden": false,
                      "id": 5163,
                      "inserted_at": "2020-07-28T20:39:21",
                      "menu_id": null,
                      "name": "Pommes",
                      "price": {
                        "amount": 3883,
                        "currency": "SEK"
                      },
                      "price_to_string": "38,83:-",
                      "restaurant_id": 39636
                    },
                    "product_extra_menu_id": 759,
                    "product_id": 5163
                  },
                  {
                    "hidden": false,
                    "id": 550,
                    "inserted_at": "2020-07-28T20:39:21",
                    "new_name": "Small Pommes",
                    "new_price": {
                      "amount": 1704,
                      "currency": "SEK"
                    },
                    "new_price_to_string": "17,04:-",
                    "product": {
                      "hidden": false,
                      "id": 5163,
                      "inserted_at": "2020-07-28T20:39:21",
                      "menu_id": null,
                      "name": "Pommes",
                      "price": {
                        "amount": 3883,
                        "currency": "SEK"
                      },
                      "price_to_string": "38,83:-",
                      "restaurant_id": 39636
                    },
                    "product_extra_menu_id": 759,
                    "product_id": 5163
                  }
                ],
                "product_id": 5159
              }
            ],
            "restaurant_id": null
          },
          {
            "hidden": false,
            "id": 5160,
            "inserted_at": "2020-07-28T20:39:21",
            "menu_id": 11469,
            "name": "30\" Whole Wheat with Scallops, Buffalo Sauce, and Sausage",
            "price": {
              "amount": 8963,
              "currency": "SEK"
            },
            "price_to_string": "89,63:-",
            "product_extra_menus": [],
            "restaurant_id": null
          },
          {
            "hidden": false,
            "id": 5161,
            "inserted_at": "2020-07-28T20:39:21",
            "menu_id": 11469,
            "name": "9\" with Venison, Mango, Pepperoni, and Classic Tomato Sauce",
            "price": {
              "amount": 7631,
              "currency": "SEK"
            },
            "price_to_string": "76,31:-",
            "product_extra_menus": [],
            "restaurant_id": null
          },
          {
            "hidden": false,
            "id": 5162,
            "inserted_at": "2020-07-28T20:39:21",
            "menu_id": 11469,
            "name": "9\" Thin Crust Meat Lovers",
            "price": {
              "amount": 8453,
              "currency": "SEK"
            },
            "price_to_string": "84,53:-",
            "product_extra_menus": [],
            "restaurant_id": null
          }
        ],
        "restaurant_id": 39636
      }
    ],
    "name": "Family Bros. Pizza",
    "unlisted_products": [
      {
        "hidden": false,
        "id": 5163,
        "inserted_at": "2020-07-28T20:39:21",
        "menu_id": null,
        "name": "Pommes",
        "price": {
          "amount": 3883,
          "currency": "SEK"
        },
        "price_to_string": "38,83:-",
        "product_extra_menus": [],
        "restaurant_id": 39636
      }
    ],
    "url": "https://family-bros.-pizza.se"
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
  "restaurant_id": 39668
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
        "id": 11478,
        "name": "Supreme",
        "products": [],
        "restaurant_id": 39668
      },
      {
        "id": 11479,
        "name": "Bacon Cheeseburger ",
        "products": [],
        "restaurant_id": 39668
      },
      {
        "id": 11480,
        "name": "Vegetarian Lovers",
        "products": [],
        "restaurant_id": 39668
      },
      {
        "id": 11481,
        "name": "Bolognese",
        "products": [],
        "restaurant_id": 39668
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
  "menu_id": 11483
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "id": 11483,
    "name": "Pesto Chicken",
    "products": [],
    "restaurant_id": 39679
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
    "created": "2020-07-28T20:39:21",
    "id": 39648,
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
    "created": "2020-07-28T20:39:21",
    "id": 39648,
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
  "restaurant_id": 39642
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "address": "32 Doyle Extension",
    "created": "2020-07-28T20:39:21",
    "id": 39642,
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
    "address": "32 Doyle Extension",
    "created": "2020-07-28T20:39:21",
    "id": 39642,
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
  "restaurant_id": 39651
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted restaurant 'Jubilee Pizza' with id 39651"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ restaurants:lobby
* __Event:__ restaurant_deleted
* __Body:__
```json
{
  "message": "Deleted restaurant 'Jubilee Pizza'",
  "restaurant_id": 39651
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
  "restaurant_id": 39657
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "id": 11475,
    "name": "test menu",
    "products": [],
    "restaurant_id": 39657
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
    "id": 11475,
    "name": "test menu",
    "products": [],
    "restaurant_id": 39657
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
  "menu_id": 11482,
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
    "id": 11482,
    "name": "some new name",
    "products": [],
    "restaurant_id": 39675
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
    "id": 11482,
    "name": "some new name",
    "products": [],
    "restaurant_id": 39675
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
  "menu_id": 11477
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted menu 'test menu1' with id 11477"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ restaurants:lobby
* __Event:__ menu_deleted
* __Body:__
```json
{
  "menu_id": 11477,
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
  "restaurant_id": 39646
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "address": "91 Susie Crossing",
    "created": "2020-07-28T20:39:21",
    "id": 39646,
    "menus": [
      {
        "id": 11471,
        "name": "Thai Chicken",
        "products": [],
        "restaurant_id": 39646
      },
      {
        "id": 11472,
        "name": "Vegetariana",
        "products": [],
        "restaurant_id": 39646
      },
      {
        "id": 11473,
        "name": "Greek",
        "products": [],
        "restaurant_id": 39646
      },
      {
        "id": 11474,
        "name": "Thai Chicken",
        "products": [],
        "restaurant_id": 39646
      }
    ],
    "name": "Pizza Pig-Out",
    "unlisted_products": [],
    "url": "https://pizza-pig-out.se"
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
  "menu_id": 11474,
  "restaurant_id": 39646
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
        "id": 11471,
        "name": "Thai Chicken",
        "products": [],
        "restaurant_id": 39646
      },
      {
        "id": 11474,
        "name": "Thai Chicken",
        "products": [],
        "restaurant_id": 39646
      },
      {
        "id": 11472,
        "name": "Vegetariana",
        "products": [],
        "restaurant_id": 39646
      },
      {
        "id": 11473,
        "name": "Greek",
        "products": [],
        "restaurant_id": 39646
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
  "menu_id": 11473,
  "restaurant_id": 39646
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
        "id": 11471,
        "name": "Thai Chicken",
        "products": [],
        "restaurant_id": 39646
      },
      {
        "id": 11474,
        "name": "Thai Chicken",
        "products": [],
        "restaurant_id": 39646
      },
      {
        "id": 11473,
        "name": "Greek",
        "products": [],
        "restaurant_id": 39646
      },
      {
        "id": 11472,
        "name": "Vegetariana",
        "products": [],
        "restaurant_id": 39646
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
  "menu_id": 11471,
  "restaurant_id": 39646
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
        "id": 11474,
        "name": "Thai Chicken",
        "products": [],
        "restaurant_id": 39646
      },
      {
        "id": 11471,
        "name": "Thai Chicken",
        "products": [],
        "restaurant_id": 39646
      },
      {
        "id": 11473,
        "name": "Greek",
        "products": [],
        "restaurant_id": 39646
      },
      {
        "id": 11472,
        "name": "Vegetariana",
        "products": [],
        "restaurant_id": 39646
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
  "menu_id": 11473,
  "restaurant_id": 39646
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
        "id": 11473,
        "name": "Greek",
        "products": [],
        "restaurant_id": 39646
      },
      {
        "id": 11474,
        "name": "Thai Chicken",
        "products": [],
        "restaurant_id": 39646
      },
      {
        "id": 11471,
        "name": "Thai Chicken",
        "products": [],
        "restaurant_id": 39646
      },
      {
        "id": 11472,
        "name": "Vegetariana",
        "products": [],
        "restaurant_id": 39646
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
  "menu_id": 11474,
  "restaurant_id": 39646
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
        "id": 11473,
        "name": "Greek",
        "products": [],
        "restaurant_id": 39646
      },
      {
        "id": 11471,
        "name": "Thai Chicken",
        "products": [],
        "restaurant_id": 39646
      },
      {
        "id": 11472,
        "name": "Vegetariana",
        "products": [],
        "restaurant_id": 39646
      },
      {
        "id": 11474,
        "name": "Thai Chicken",
        "products": [],
        "restaurant_id": 39646
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
  "user_id": 49906
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
  "menu_id": 11458
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
        "id": 5140,
        "inserted_at": "2020-07-28T20:39:20",
        "menu_id": 11458,
        "name": "30\" Fajita",
        "price": {
          "amount": 9705,
          "currency": "SEK"
        },
        "price_to_string": "97,05:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5141,
        "inserted_at": "2020-07-28T20:39:20",
        "menu_id": 11458,
        "name": "Large Kebab",
        "price": {
          "amount": 8791,
          "currency": "SEK"
        },
        "price_to_string": "87,91:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5142,
        "inserted_at": "2020-07-28T20:39:20",
        "menu_id": 11458,
        "name": "11\" Stuffed Crust with Lactose Free Cheese, Gorgonzola, Gravy, and Chicken",
        "price": {
          "amount": 8529,
          "currency": "SEK"
        },
        "price_to_string": "85,29:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5143,
        "inserted_at": "2020-07-28T20:39:20",
        "menu_id": 11458,
        "name": "Personal Veggie Korma",
        "price": {
          "amount": 7142,
          "currency": "SEK"
        },
        "price_to_string": "71,42:-",
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
  "menu_id": 11457,
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
    "id": 5139,
    "inserted_at": "2020-07-28T20:39:20",
    "menu_id": 11457,
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
    "id": 5139,
    "inserted_at": "2020-07-28T20:39:20",
    "menu_id": 11457,
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
  "restaurant_id": 39614
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "hidden": true,
    "id": 5136,
    "inserted_at": "2020-07-28T20:39:20",
    "menu_id": null,
    "name": "test product 29",
    "price": {
      "amount": 2900,
      "currency": "SEK"
    },
    "price_to_string": "29:-",
    "product_extra_menus": [],
    "restaurant_id": 39614
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
  "product_id": 5144
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "hidden": false,
    "id": 5144,
    "inserted_at": "2020-07-28T20:39:20",
    "menu_id": 11459,
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
    "id": 5144,
    "inserted_at": "2020-07-28T20:39:20",
    "menu_id": 11459,
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
  "product_id": 5149
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted product 'Extra-Large Onion & Gorgonzola' with id 5149"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ merchandise:lobby
* __Event:__ product_deleted
* __Body:__
```json
{
  "message": "Deleted product 'Extra-Large Onion & Gorgonzola'",
  "product_id": 5149
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
  "menu_id": 11464
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
        "id": 5151,
        "inserted_at": "2020-07-28T20:39:20",
        "menu_id": 11464,
        "name": "Extra-Large Italian Deli",
        "price": {
          "amount": 7147,
          "currency": "SEK"
        },
        "price_to_string": "71,47:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5152,
        "inserted_at": "2020-07-28T20:39:20",
        "menu_id": 11464,
        "name": "Medium Capricciosa",
        "price": {
          "amount": 8728,
          "currency": "SEK"
        },
        "price_to_string": "87,28:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5153,
        "inserted_at": "2020-07-28T20:39:20",
        "menu_id": 11464,
        "name": "Family with Caramelised Onions, Scallops, and Red Onion",
        "price": {
          "amount": 8132,
          "currency": "SEK"
        },
        "price_to_string": "81,32:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5154,
        "inserted_at": "2020-07-28T20:39:20",
        "menu_id": 11464,
        "name": "14\" Double Dutch",
        "price": {
          "amount": 9972,
          "currency": "SEK"
        },
        "price_to_string": "99,72:-",
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
  "menu_id": 11464,
  "product_id": 5154
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
        "id": 5151,
        "inserted_at": "2020-07-28T20:39:20",
        "menu_id": 11464,
        "name": "Extra-Large Italian Deli",
        "price": {
          "amount": 7147,
          "currency": "SEK"
        },
        "price_to_string": "71,47:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5154,
        "inserted_at": "2020-07-28T20:39:20",
        "menu_id": 11464,
        "name": "14\" Double Dutch",
        "price": {
          "amount": 9972,
          "currency": "SEK"
        },
        "price_to_string": "99,72:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5152,
        "inserted_at": "2020-07-28T20:39:20",
        "menu_id": 11464,
        "name": "Medium Capricciosa",
        "price": {
          "amount": 8728,
          "currency": "SEK"
        },
        "price_to_string": "87,28:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5153,
        "inserted_at": "2020-07-28T20:39:20",
        "menu_id": 11464,
        "name": "Family with Caramelised Onions, Scallops, and Red Onion",
        "price": {
          "amount": 8132,
          "currency": "SEK"
        },
        "price_to_string": "81,32:-",
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
  "menu_id": 11464,
  "product_id": 5153
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
        "id": 5151,
        "inserted_at": "2020-07-28T20:39:20",
        "menu_id": 11464,
        "name": "Extra-Large Italian Deli",
        "price": {
          "amount": 7147,
          "currency": "SEK"
        },
        "price_to_string": "71,47:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5154,
        "inserted_at": "2020-07-28T20:39:20",
        "menu_id": 11464,
        "name": "14\" Double Dutch",
        "price": {
          "amount": 9972,
          "currency": "SEK"
        },
        "price_to_string": "99,72:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5153,
        "inserted_at": "2020-07-28T20:39:20",
        "menu_id": 11464,
        "name": "Family with Caramelised Onions, Scallops, and Red Onion",
        "price": {
          "amount": 8132,
          "currency": "SEK"
        },
        "price_to_string": "81,32:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5152,
        "inserted_at": "2020-07-28T20:39:20",
        "menu_id": 11464,
        "name": "Medium Capricciosa",
        "price": {
          "amount": 8728,
          "currency": "SEK"
        },
        "price_to_string": "87,28:-",
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
  "menu_id": 11464,
  "product_id": 5151
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
        "id": 5154,
        "inserted_at": "2020-07-28T20:39:20",
        "menu_id": 11464,
        "name": "14\" Double Dutch",
        "price": {
          "amount": 9972,
          "currency": "SEK"
        },
        "price_to_string": "99,72:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5151,
        "inserted_at": "2020-07-28T20:39:20",
        "menu_id": 11464,
        "name": "Extra-Large Italian Deli",
        "price": {
          "amount": 7147,
          "currency": "SEK"
        },
        "price_to_string": "71,47:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5153,
        "inserted_at": "2020-07-28T20:39:20",
        "menu_id": 11464,
        "name": "Family with Caramelised Onions, Scallops, and Red Onion",
        "price": {
          "amount": 8132,
          "currency": "SEK"
        },
        "price_to_string": "81,32:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5152,
        "inserted_at": "2020-07-28T20:39:20",
        "menu_id": 11464,
        "name": "Medium Capricciosa",
        "price": {
          "amount": 8728,
          "currency": "SEK"
        },
        "price_to_string": "87,28:-",
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
  "menu_id": 11464,
  "product_id": 5153
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
        "id": 5153,
        "inserted_at": "2020-07-28T20:39:20",
        "menu_id": 11464,
        "name": "Family with Caramelised Onions, Scallops, and Red Onion",
        "price": {
          "amount": 8132,
          "currency": "SEK"
        },
        "price_to_string": "81,32:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5154,
        "inserted_at": "2020-07-28T20:39:20",
        "menu_id": 11464,
        "name": "14\" Double Dutch",
        "price": {
          "amount": 9972,
          "currency": "SEK"
        },
        "price_to_string": "99,72:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5151,
        "inserted_at": "2020-07-28T20:39:20",
        "menu_id": 11464,
        "name": "Extra-Large Italian Deli",
        "price": {
          "amount": 7147,
          "currency": "SEK"
        },
        "price_to_string": "71,47:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5152,
        "inserted_at": "2020-07-28T20:39:20",
        "menu_id": 11464,
        "name": "Medium Capricciosa",
        "price": {
          "amount": 8728,
          "currency": "SEK"
        },
        "price_to_string": "87,28:-",
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
  "menu_id": 11464,
  "product_id": 5154
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
        "id": 5153,
        "inserted_at": "2020-07-28T20:39:20",
        "menu_id": 11464,
        "name": "Family with Caramelised Onions, Scallops, and Red Onion",
        "price": {
          "amount": 8132,
          "currency": "SEK"
        },
        "price_to_string": "81,32:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5151,
        "inserted_at": "2020-07-28T20:39:20",
        "menu_id": 11464,
        "name": "Extra-Large Italian Deli",
        "price": {
          "amount": 7147,
          "currency": "SEK"
        },
        "price_to_string": "71,47:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5152,
        "inserted_at": "2020-07-28T20:39:20",
        "menu_id": 11464,
        "name": "Medium Capricciosa",
        "price": {
          "amount": 8728,
          "currency": "SEK"
        },
        "price_to_string": "87,28:-",
        "product_extra_menus": [],
        "restaurant_id": null
      },
      {
        "hidden": false,
        "id": 5154,
        "inserted_at": "2020-07-28T20:39:20",
        "menu_id": 11464,
        "name": "14\" Double Dutch",
        "price": {
          "amount": 9972,
          "currency": "SEK"
        },
        "price_to_string": "99,72:-",
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
  "product_id": 5156
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "default_extra": null,
    "id": 757,
    "inserted_at": "2020-07-28T20:39:20",
    "mandatory": false,
    "name": "Sauces",
    "pick_only_one": false,
    "product_extras": [],
    "product_id": 5156
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
    "id": 757,
    "inserted_at": "2020-07-28T20:39:20",
    "mandatory": false,
    "name": "Sauces",
    "pick_only_one": false,
    "product_extras": [],
    "product_id": 5156
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
  "product_extra_menu_id": 756
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "default_extra": null,
    "id": 756,
    "inserted_at": "2020-07-28T20:39:20",
    "mandatory": true,
    "name": "New Sauces",
    "pick_only_one": true,
    "product_extras": [],
    "product_id": 5155
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
    "id": 756,
    "inserted_at": "2020-07-28T20:39:20",
    "mandatory": true,
    "name": "New Sauces",
    "pick_only_one": true,
    "product_extras": [],
    "product_id": 5155
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
  "product_extra_menu_id": 753
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted product extra menu: 'Sauces' with id 753"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ merchandise:lobby
* __Event:__ product_extra_menu_deleted
* __Body:__
```json
{
  "message": "Deleted product extra menu: 'Sauces'",
  "product_extra_menu_id": 753
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
  "new_name": "Classic Tomato Sauce",
  "new_price": 1000,
  "product_extra_menu_id": 755,
  "product_id": 5148
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "hidden": false,
    "id": 548,
    "inserted_at": "2020-07-28T20:39:20",
    "new_name": "Classic Tomato Sauce",
    "new_price": {
      "amount": 1000,
      "currency": "SEK"
    },
    "new_price_to_string": "10:-",
    "product": {
      "hidden": false,
      "id": 5148,
      "inserted_at": "2020-07-28T20:39:20",
      "menu_id": null,
      "name": "Classic Tomato Sauce",
      "price": {
        "amount": 3479,
        "currency": "SEK"
      },
      "price_to_string": "34,79:-",
      "restaurant_id": 39623
    },
    "product_extra_menu_id": 755,
    "product_id": 5148
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
    "id": 548,
    "inserted_at": "2020-07-28T20:39:20",
    "new_name": "Classic Tomato Sauce",
    "new_price": {
      "amount": 1000,
      "currency": "SEK"
    },
    "new_price_to_string": "10:-",
    "product": {
      "hidden": false,
      "id": 5148,
      "inserted_at": "2020-07-28T20:39:20",
      "menu_id": null,
      "name": "Classic Tomato Sauce",
      "price": {
        "amount": 3479,
        "currency": "SEK"
      },
      "price_to_string": "34,79:-",
      "restaurant_id": 39623
    },
    "product_extra_menu_id": 755,
    "product_id": 5148
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
  "product_extra_id": 547
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "hidden": false,
    "id": 547,
    "inserted_at": "2020-07-28T20:39:20",
    "new_name": "Sauce X",
    "new_price": {
      "amount": 900,
      "currency": "SEK"
    },
    "new_price_to_string": "9:-",
    "product": {
      "hidden": false,
      "id": 5146,
      "inserted_at": "2020-07-28T20:39:20",
      "menu_id": null,
      "name": "Chipolte Sauce",
      "price": {
        "amount": 3769,
        "currency": "SEK"
      },
      "price_to_string": "37,69:-",
      "restaurant_id": 39621
    },
    "product_extra_menu_id": 754,
    "product_id": 5146
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
    "id": 547,
    "inserted_at": "2020-07-28T20:39:20",
    "new_name": "Sauce X",
    "new_price": {
      "amount": 900,
      "currency": "SEK"
    },
    "new_price_to_string": "9:-",
    "product": {
      "hidden": false,
      "id": 5146,
      "inserted_at": "2020-07-28T20:39:20",
      "menu_id": null,
      "name": "Chipolte Sauce",
      "price": {
        "amount": 3769,
        "currency": "SEK"
      },
      "price_to_string": "37,69:-",
      "restaurant_id": 39621
    },
    "product_extra_menu_id": 754,
    "product_id": 5146
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
  "product_extra_id": 549
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted product extra: 'Sauce Y' with id 549"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ merchandise:lobby
* __Event:__ product_extra_deleted
* __Body:__
```json
{
  "message": "Deleted product extra: 'Sauce Y'",
  "product_extra_id": 549
}
```
---
