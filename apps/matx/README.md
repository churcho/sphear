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
    * [user actions - update a product](#channel-merchandise-lobby-user-actions-update-a-product)
    * [user actions - delete a product](#channel-merchandise-lobby-user-actions-delete-a-product)
    * [user actions - change sequence of product](#channel-merchandise-lobby-user-actions-change-sequence-of-product)

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
  "email": "user-576460752303422204@example.com",
  "password": "hello world!"
}
```

##### ← <ins>Response to you</ins>
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FiQuioW7MADfv7IAAALi
```
* __Response body:__
```json
{
  "success": {
    "token": "GlNGt53Q3lXGcWCjbw1wsjdD7v/aZd4iYwKndcl+Wbg="
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
  "email": "user-576460752303422236@example.com",
  "password": "lol"
}
```

##### ← <ins>Response to you</ins>
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FiQuioEVAIA7UvkAAABn
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
  "email": "user-576460752303421723@example.com",
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
x-request-id: FiQuioW7MADUkSwAAAcF
```
* __Response body:__
```json
{
  "success": {
    "email": "user-576460752303421723@example.com",
    "token": "oCQfpwKccd0SzUvNO83Vo+eYXVGbAbDbWvYfEOLRksE="
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
x-request-id: FiQuioEVAIAaXdYAAACH
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
  "user_id": 42972
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
        "address": "1949 Marquardt Mountains",
        "created": "2020-07-22T20:55:42",
        "id": 30373,
        "menus": [],
        "name": "Pizza on a Stick",
        "url": "https://pizza-on-a-stick.se"
      },
      {
        "address": "459 Ebert Squares",
        "created": "2020-07-22T20:55:42",
        "id": 30374,
        "menus": [],
        "name": "Paisanos",
        "url": "https://paisanos.se"
      },
      {
        "address": "53307 Aufderhar Shoal",
        "created": "2020-07-22T20:55:42",
        "id": 30375,
        "menus": [],
        "name": "Pizza De Roma",
        "url": "https://pizza-de-roma.se"
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
  "restaurant_id": 30315
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "address": "2296 Harber Grove",
    "created": "2020-07-22T20:55:41",
    "id": 30315,
    "menus": [
      {
        "id": 7078,
        "name": "Margherita",
        "products": [
          {
            "id": 1759,
            "inserted_at": "2020-07-22T20:55:41",
            "menu_id": 7078,
            "name": "18\" Veggie Korma",
            "price": {
              "amount": 8475,
              "currency": "SEK"
            },
            "price_to_string": "84,75:-"
          },
          {
            "id": 1760,
            "inserted_at": "2020-07-22T20:55:41",
            "menu_id": 7078,
            "name": "Large Gluten-Free Quinoa Meat Lovers",
            "price": {
              "amount": 7935,
              "currency": "SEK"
            },
            "price_to_string": "79,35:-"
          },
          {
            "id": 1761,
            "inserted_at": "2020-07-22T20:55:41",
            "menu_id": 7078,
            "name": "14\" Taco",
            "price": {
              "amount": 7141,
              "currency": "SEK"
            },
            "price_to_string": "71,41:-"
          },
          {
            "id": 1762,
            "inserted_at": "2020-07-22T20:55:41",
            "menu_id": 7078,
            "name": "Extra-Large Gluten-Free Quinoa with Smoked Salmon",
            "price": {
              "amount": 9048,
              "currency": "SEK"
            },
            "price_to_string": "90,48:-"
          }
        ],
        "restaurant_id": 30315
      }
    ],
    "name": "Paisanos",
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
  "restaurant_id": 30338
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
        "id": 7085,
        "name": "Quattro Formaggi",
        "products": [],
        "restaurant_id": 30338
      },
      {
        "id": 7086,
        "name": "Shrimp Club",
        "products": [],
        "restaurant_id": 30338
      },
      {
        "id": 7087,
        "name": "Frutti di mare",
        "products": [],
        "restaurant_id": 30338
      },
      {
        "id": 7088,
        "name": "All Dressed",
        "products": [],
        "restaurant_id": 30338
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
  "menu_id": 7083
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "id": 7083,
    "name": "Perogie",
    "products": [],
    "restaurant_id": 30333
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
    "created": "2020-07-22T20:55:42",
    "id": 30359,
    "menus": [],
    "name": "test",
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
    "created": "2020-07-22T20:55:42",
    "id": 30359,
    "menus": [],
    "name": "test",
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
  "restaurant_id": 30365
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "address": "67627 Caleigh Port",
    "created": "2020-07-22T20:55:42",
    "id": 30365,
    "menus": [],
    "name": "new name",
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
    "address": "67627 Caleigh Port",
    "created": "2020-07-22T20:55:42",
    "id": 30365,
    "menus": [],
    "name": "new name",
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
  "restaurant_id": 30345
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted restaurant 'Gamer Pizzas' with id 30345"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ restaurants:lobby
* __Event:__ restaurant_deleted
* __Body:__
```json
{
  "message": "Deleted restaurant 'Gamer Pizzas'",
  "restaurant_id": 30345
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
  "restaurant_id": 30361
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "id": 7093,
    "name": "test menu",
    "products": [],
    "restaurant_id": 30361
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
    "id": 7093,
    "name": "test menu",
    "products": [],
    "restaurant_id": 30361
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
  "menu_id": 7095,
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
    "id": 7095,
    "name": "some new name",
    "products": [],
    "restaurant_id": 30371
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
    "id": 7095,
    "name": "some new name",
    "products": [],
    "restaurant_id": 30371
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
  "menu_id": 7084
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted menu 'test menu1' with id 7084"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ restaurants:lobby
* __Event:__ menu_deleted
* __Body:__
```json
{
  "menu_id": 7084,
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
  "restaurant_id": 30347
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "address": "988 Toni Keys",
    "created": "2020-07-22T20:55:42",
    "id": 30347,
    "menus": [
      {
        "id": 7089,
        "name": "Four Seasons",
        "products": [],
        "restaurant_id": 30347
      },
      {
        "id": 7090,
        "name": "Supreme",
        "products": [],
        "restaurant_id": 30347
      },
      {
        "id": 7091,
        "name": "Bacon Cheeseburger ",
        "products": [],
        "restaurant_id": 30347
      },
      {
        "id": 7092,
        "name": "Frutti di mare",
        "products": [],
        "restaurant_id": 30347
      }
    ],
    "name": "CosaNostra Pizza",
    "url": "https://cosanostra-pizza.se"
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
  "menu_id": 7092,
  "restaurant_id": 30347
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
        "id": 7089,
        "name": "Four Seasons",
        "products": [],
        "restaurant_id": 30347
      },
      {
        "id": 7092,
        "name": "Frutti di mare",
        "products": [],
        "restaurant_id": 30347
      },
      {
        "id": 7090,
        "name": "Supreme",
        "products": [],
        "restaurant_id": 30347
      },
      {
        "id": 7091,
        "name": "Bacon Cheeseburger ",
        "products": [],
        "restaurant_id": 30347
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
  "menu_id": 7091,
  "restaurant_id": 30347
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
        "id": 7089,
        "name": "Four Seasons",
        "products": [],
        "restaurant_id": 30347
      },
      {
        "id": 7092,
        "name": "Frutti di mare",
        "products": [],
        "restaurant_id": 30347
      },
      {
        "id": 7091,
        "name": "Bacon Cheeseburger ",
        "products": [],
        "restaurant_id": 30347
      },
      {
        "id": 7090,
        "name": "Supreme",
        "products": [],
        "restaurant_id": 30347
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
  "menu_id": 7089,
  "restaurant_id": 30347
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
        "id": 7092,
        "name": "Frutti di mare",
        "products": [],
        "restaurant_id": 30347
      },
      {
        "id": 7089,
        "name": "Four Seasons",
        "products": [],
        "restaurant_id": 30347
      },
      {
        "id": 7091,
        "name": "Bacon Cheeseburger ",
        "products": [],
        "restaurant_id": 30347
      },
      {
        "id": 7090,
        "name": "Supreme",
        "products": [],
        "restaurant_id": 30347
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
  "menu_id": 7091,
  "restaurant_id": 30347
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
        "id": 7091,
        "name": "Bacon Cheeseburger ",
        "products": [],
        "restaurant_id": 30347
      },
      {
        "id": 7092,
        "name": "Frutti di mare",
        "products": [],
        "restaurant_id": 30347
      },
      {
        "id": 7089,
        "name": "Four Seasons",
        "products": [],
        "restaurant_id": 30347
      },
      {
        "id": 7090,
        "name": "Supreme",
        "products": [],
        "restaurant_id": 30347
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
  "menu_id": 7092,
  "restaurant_id": 30347
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
        "id": 7091,
        "name": "Bacon Cheeseburger ",
        "products": [],
        "restaurant_id": 30347
      },
      {
        "id": 7089,
        "name": "Four Seasons",
        "products": [],
        "restaurant_id": 30347
      },
      {
        "id": 7090,
        "name": "Supreme",
        "products": [],
        "restaurant_id": 30347
      },
      {
        "id": 7092,
        "name": "Frutti di mare",
        "products": [],
        "restaurant_id": 30347
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
  "user_id": 42990
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
  "menu_id": 7105
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
        "id": 1768,
        "inserted_at": "2020-07-22T20:55:43",
        "menu_id": 7105,
        "name": "10\" Thick Crust with Chorizo and Buffalo Chicken",
        "price": {
          "amount": 8258,
          "currency": "SEK"
        },
        "price_to_string": "82,58:-"
      },
      {
        "id": 1769,
        "inserted_at": "2020-07-22T20:55:43",
        "menu_id": 7105,
        "name": "18\" Vegetarian Lovers",
        "price": {
          "amount": 7939,
          "currency": "SEK"
        },
        "price_to_string": "79,39:-"
      },
      {
        "id": 1770,
        "inserted_at": "2020-07-22T20:55:43",
        "menu_id": 7105,
        "name": "16\" Prociutto Arugala",
        "price": {
          "amount": 7041,
          "currency": "SEK"
        },
        "price_to_string": "70,41:-"
      },
      {
        "id": 1771,
        "inserted_at": "2020-07-22T20:55:43",
        "menu_id": 7105,
        "name": "Medium New Haven Style Onion & Gorgonzola",
        "price": {
          "amount": 7000,
          "currency": "SEK"
        },
        "price_to_string": "70:-"
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
  "menu_id": 7102,
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
    "id": 1767,
    "inserted_at": "2020-07-22T20:55:42",
    "menu_id": 7102,
    "name": "test product 99",
    "price": {
      "amount": 9900,
      "currency": "SEK"
    },
    "price_to_string": "99:-"
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
    "id": 1767,
    "inserted_at": "2020-07-22T20:55:42",
    "menu_id": 7102,
    "name": "test product 99",
    "price": {
      "amount": 9900,
      "currency": "SEK"
    },
    "price_to_string": "99:-"
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
  "product_id": 1773
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "id": 1773,
    "inserted_at": "2020-07-22T20:55:43",
    "menu_id": 7112,
    "name": "new product name",
    "price": {
      "amount": 133700,
      "currency": "SEK"
    },
    "price_to_string": "1.337:-"
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
    "id": 1773,
    "inserted_at": "2020-07-22T20:55:43",
    "menu_id": 7112,
    "name": "new product name",
    "price": {
      "amount": 133700,
      "currency": "SEK"
    },
    "price_to_string": "1.337:-"
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
  "product_id": 1774
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted product '16\" Kosher Canadian' with id 1774"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ merchandise:lobby
* __Event:__ product_deleted
* __Body:__
```json
{
  "message": "Deleted product '16\" Kosher Canadian'",
  "product_id": 1774
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
  "menu_id": 7097
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
        "id": 1763,
        "inserted_at": "2020-07-22T20:55:42",
        "menu_id": 7097,
        "name": "16\" with Black Olives, Salami, Gorgonzola, Egg, and Zucchini",
        "price": {
          "amount": 7473,
          "currency": "SEK"
        },
        "price_to_string": "74,73:-"
      },
      {
        "id": 1764,
        "inserted_at": "2020-07-22T20:55:42",
        "menu_id": 7097,
        "name": "Large with Smoked Salmon",
        "price": {
          "amount": 8656,
          "currency": "SEK"
        },
        "price_to_string": "86,56:-"
      },
      {
        "id": 1765,
        "inserted_at": "2020-07-22T20:55:42",
        "menu_id": 7097,
        "name": "Small Double Dutch",
        "price": {
          "amount": 8981,
          "currency": "SEK"
        },
        "price_to_string": "89,81:-"
      },
      {
        "id": 1766,
        "inserted_at": "2020-07-22T20:55:42",
        "menu_id": 7097,
        "name": "12\" Curry Banana",
        "price": {
          "amount": 8840,
          "currency": "SEK"
        },
        "price_to_string": "88,40:-"
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
  "menu_id": 7097,
  "product_id": 1766
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
        "id": 1763,
        "inserted_at": "2020-07-22T20:55:42",
        "menu_id": 7097,
        "name": "16\" with Black Olives, Salami, Gorgonzola, Egg, and Zucchini",
        "price": {
          "amount": 7473,
          "currency": "SEK"
        },
        "price_to_string": "74,73:-"
      },
      {
        "id": 1766,
        "inserted_at": "2020-07-22T20:55:42",
        "menu_id": 7097,
        "name": "12\" Curry Banana",
        "price": {
          "amount": 8840,
          "currency": "SEK"
        },
        "price_to_string": "88,40:-"
      },
      {
        "id": 1764,
        "inserted_at": "2020-07-22T20:55:42",
        "menu_id": 7097,
        "name": "Large with Smoked Salmon",
        "price": {
          "amount": 8656,
          "currency": "SEK"
        },
        "price_to_string": "86,56:-"
      },
      {
        "id": 1765,
        "inserted_at": "2020-07-22T20:55:42",
        "menu_id": 7097,
        "name": "Small Double Dutch",
        "price": {
          "amount": 8981,
          "currency": "SEK"
        },
        "price_to_string": "89,81:-"
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
  "menu_id": 7097,
  "product_id": 1765
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
        "id": 1763,
        "inserted_at": "2020-07-22T20:55:42",
        "menu_id": 7097,
        "name": "16\" with Black Olives, Salami, Gorgonzola, Egg, and Zucchini",
        "price": {
          "amount": 7473,
          "currency": "SEK"
        },
        "price_to_string": "74,73:-"
      },
      {
        "id": 1766,
        "inserted_at": "2020-07-22T20:55:42",
        "menu_id": 7097,
        "name": "12\" Curry Banana",
        "price": {
          "amount": 8840,
          "currency": "SEK"
        },
        "price_to_string": "88,40:-"
      },
      {
        "id": 1765,
        "inserted_at": "2020-07-22T20:55:42",
        "menu_id": 7097,
        "name": "Small Double Dutch",
        "price": {
          "amount": 8981,
          "currency": "SEK"
        },
        "price_to_string": "89,81:-"
      },
      {
        "id": 1764,
        "inserted_at": "2020-07-22T20:55:42",
        "menu_id": 7097,
        "name": "Large with Smoked Salmon",
        "price": {
          "amount": 8656,
          "currency": "SEK"
        },
        "price_to_string": "86,56:-"
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
  "menu_id": 7097,
  "product_id": 1763
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
        "id": 1766,
        "inserted_at": "2020-07-22T20:55:42",
        "menu_id": 7097,
        "name": "12\" Curry Banana",
        "price": {
          "amount": 8840,
          "currency": "SEK"
        },
        "price_to_string": "88,40:-"
      },
      {
        "id": 1763,
        "inserted_at": "2020-07-22T20:55:42",
        "menu_id": 7097,
        "name": "16\" with Black Olives, Salami, Gorgonzola, Egg, and Zucchini",
        "price": {
          "amount": 7473,
          "currency": "SEK"
        },
        "price_to_string": "74,73:-"
      },
      {
        "id": 1765,
        "inserted_at": "2020-07-22T20:55:42",
        "menu_id": 7097,
        "name": "Small Double Dutch",
        "price": {
          "amount": 8981,
          "currency": "SEK"
        },
        "price_to_string": "89,81:-"
      },
      {
        "id": 1764,
        "inserted_at": "2020-07-22T20:55:42",
        "menu_id": 7097,
        "name": "Large with Smoked Salmon",
        "price": {
          "amount": 8656,
          "currency": "SEK"
        },
        "price_to_string": "86,56:-"
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
  "menu_id": 7097,
  "product_id": 1765
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
        "id": 1765,
        "inserted_at": "2020-07-22T20:55:42",
        "menu_id": 7097,
        "name": "Small Double Dutch",
        "price": {
          "amount": 8981,
          "currency": "SEK"
        },
        "price_to_string": "89,81:-"
      },
      {
        "id": 1766,
        "inserted_at": "2020-07-22T20:55:42",
        "menu_id": 7097,
        "name": "12\" Curry Banana",
        "price": {
          "amount": 8840,
          "currency": "SEK"
        },
        "price_to_string": "88,40:-"
      },
      {
        "id": 1763,
        "inserted_at": "2020-07-22T20:55:42",
        "menu_id": 7097,
        "name": "16\" with Black Olives, Salami, Gorgonzola, Egg, and Zucchini",
        "price": {
          "amount": 7473,
          "currency": "SEK"
        },
        "price_to_string": "74,73:-"
      },
      {
        "id": 1764,
        "inserted_at": "2020-07-22T20:55:42",
        "menu_id": 7097,
        "name": "Large with Smoked Salmon",
        "price": {
          "amount": 8656,
          "currency": "SEK"
        },
        "price_to_string": "86,56:-"
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
  "menu_id": 7097,
  "product_id": 1766
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
        "id": 1765,
        "inserted_at": "2020-07-22T20:55:42",
        "menu_id": 7097,
        "name": "Small Double Dutch",
        "price": {
          "amount": 8981,
          "currency": "SEK"
        },
        "price_to_string": "89,81:-"
      },
      {
        "id": 1763,
        "inserted_at": "2020-07-22T20:55:42",
        "menu_id": 7097,
        "name": "16\" with Black Olives, Salami, Gorgonzola, Egg, and Zucchini",
        "price": {
          "amount": 7473,
          "currency": "SEK"
        },
        "price_to_string": "74,73:-"
      },
      {
        "id": 1764,
        "inserted_at": "2020-07-22T20:55:42",
        "menu_id": 7097,
        "name": "Large with Smoked Salmon",
        "price": {
          "amount": 8656,
          "currency": "SEK"
        },
        "price_to_string": "86,56:-"
      },
      {
        "id": 1766,
        "inserted_at": "2020-07-22T20:55:42",
        "menu_id": 7097,
        "name": "12\" Curry Banana",
        "price": {
          "amount": 8840,
          "currency": "SEK"
        },
        "price_to_string": "88,40:-"
      }
    ]
  }
}
```
---
