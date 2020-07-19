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
    * [user actions - change order of menu](#channel-restaurants-lobby-user-actions-change-order-of-menu)
  * [(REST) Register account](#rest-register-account)
    * [rest-register-account-create](#rest-register-account-create)
  * [(REST) Login account](#rest-login-account)
    * [rest-login-account-create](#rest-login-account-create)

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
  "user_id": 33579
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
        "address": "trollvägen 413",
        "created": "2020-07-19T13:12:26",
        "id": 17189,
        "menus": [],
        "name": "restaurant 477",
        "url": "https://445.io"
      },
      {
        "address": "trollvägen 253",
        "created": "2020-07-19T13:12:26",
        "id": 17190,
        "menus": [],
        "name": "restaurant 317",
        "url": "https://285.io"
      },
      {
        "address": "trollvägen 157",
        "created": "2020-07-19T13:12:26",
        "id": 17191,
        "menus": [],
        "name": "restaurant 221",
        "url": "https://189.io"
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
  "restaurant_id": 17197
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "address": "trollvägen 190",
    "created": "2020-07-19T13:12:26",
    "id": 17197,
    "menus": [],
    "name": "restaurant 254",
    "url": "https://222.io"
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
  "restaurant_id": 17180
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
        "created": "2020-07-19T13:12:26",
        "id": 2078,
        "name": "test menu1",
        "restaurant_id": 17180
      },
      {
        "created": "2020-07-19T13:12:26",
        "id": 2079,
        "name": "test menu2",
        "restaurant_id": 17180
      },
      {
        "created": "2020-07-19T13:12:26",
        "id": 2080,
        "name": "test menu3",
        "restaurant_id": 17180
      },
      {
        "created": "2020-07-19T13:12:26",
        "id": 2081,
        "name": "test menu4",
        "restaurant_id": 17180
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
  "menu_id": 2083
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "created": "2020-07-19T13:12:26",
    "id": 2083,
    "name": "test menu1",
    "restaurant_id": 17194
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
    "created": "2020-07-19T13:12:26",
    "id": 17204,
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
    "created": "2020-07-19T13:12:26",
    "id": 17204,
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
  "restaurant_id": 17201
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "address": "trollvägen 884",
    "created": "2020-07-19T13:12:26",
    "id": 17201,
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
    "address": "trollvägen 884",
    "created": "2020-07-19T13:12:26",
    "id": 17201,
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
  "restaurant_id": 17184
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted restaurant 'restaurant 669' with id 17184"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ restaurants:lobby
* __Event:__ restaurant_deleted
* __Body:__
```json
{
  "message": "Deleted restaurant 'restaurant 669'",
  "restaurant_id": 17184
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
  "restaurant_id": 17166
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "created": "2020-07-19T13:12:26",
    "id": 2072,
    "name": "test menu",
    "restaurant_id": 17166
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
    "created": "2020-07-19T13:12:26",
    "id": 2072,
    "name": "test menu",
    "restaurant_id": 17166
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
  "menu_id": 2082,
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
    "created": "2020-07-19T13:12:26",
    "id": 2082,
    "name": "some new name",
    "restaurant_id": 17188
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
    "created": "2020-07-19T13:12:26",
    "id": 2082,
    "name": "some new name",
    "restaurant_id": 17188
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
  "menu_id": 2073
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted menu 'test menu1' with id 2073"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ restaurants:lobby
* __Event:__ menu_deleted
* __Body:__
```json
{
  "menu_id": 2073,
  "message": "Deleted menu 'test menu1'"
}
```
---
## <a id=channel-restaurants-lobby-user-actions-change-order-of-menu></a>user actions - change order of menu
#### → <ins>Message to server</ins>
* __Topic:__ restaurants:lobby
* __Event:__ get_restaurant
* __Body:__
```json
{
  "restaurant_id": 17177
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "address": "trollvägen 213",
    "created": "2020-07-19T13:12:26",
    "id": 17177,
    "menus": [
      {
        "id": 2074,
        "name": "test menu1"
      },
      {
        "id": 2075,
        "name": "test menu2"
      },
      {
        "id": 2076,
        "name": "test menu3"
      },
      {
        "id": 2077,
        "name": "test menu4"
      }
    ],
    "name": "restaurant 277",
    "url": "https://245.io"
  }
}
```
#### → <ins>Message to server</ins>
* __Topic:__ restaurants:lobby
* __Event:__ change_menu_order
* __Body:__
```json
{
  "action": "insert_at",
  "index": 1,
  "menu_id": 2077,
  "restaurant_id": 17177
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
        "created": "2020-07-19T13:12:26",
        "id": 2074,
        "name": "test menu1",
        "restaurant_id": 17177
      },
      {
        "created": "2020-07-19T13:12:26",
        "id": 2077,
        "name": "test menu4",
        "restaurant_id": 17177
      },
      {
        "created": "2020-07-19T13:12:26",
        "id": 2075,
        "name": "test menu2",
        "restaurant_id": 17177
      },
      {
        "created": "2020-07-19T13:12:26",
        "id": 2076,
        "name": "test menu3",
        "restaurant_id": 17177
      }
    ]
  }
}
```
#### → <ins>Message to server</ins>
* __Topic:__ restaurants:lobby
* __Event:__ change_menu_order
* __Body:__
```json
{
  "action": "higher",
  "menu_id": 2076,
  "restaurant_id": 17177
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
        "created": "2020-07-19T13:12:26",
        "id": 2074,
        "name": "test menu1",
        "restaurant_id": 17177
      },
      {
        "created": "2020-07-19T13:12:26",
        "id": 2077,
        "name": "test menu4",
        "restaurant_id": 17177
      },
      {
        "created": "2020-07-19T13:12:26",
        "id": 2076,
        "name": "test menu3",
        "restaurant_id": 17177
      },
      {
        "created": "2020-07-19T13:12:26",
        "id": 2075,
        "name": "test menu2",
        "restaurant_id": 17177
      }
    ]
  }
}
```
#### → <ins>Message to server</ins>
* __Topic:__ restaurants:lobby
* __Event:__ change_menu_order
* __Body:__
```json
{
  "action": "lower",
  "menu_id": 2074,
  "restaurant_id": 17177
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
        "created": "2020-07-19T13:12:26",
        "id": 2077,
        "name": "test menu4",
        "restaurant_id": 17177
      },
      {
        "created": "2020-07-19T13:12:26",
        "id": 2074,
        "name": "test menu1",
        "restaurant_id": 17177
      },
      {
        "created": "2020-07-19T13:12:26",
        "id": 2076,
        "name": "test menu3",
        "restaurant_id": 17177
      },
      {
        "created": "2020-07-19T13:12:26",
        "id": 2075,
        "name": "test menu2",
        "restaurant_id": 17177
      }
    ]
  }
}
```
#### → <ins>Message to server</ins>
* __Topic:__ restaurants:lobby
* __Event:__ change_menu_order
* __Body:__
```json
{
  "action": "to_top",
  "menu_id": 2076,
  "restaurant_id": 17177
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
        "created": "2020-07-19T13:12:26",
        "id": 2076,
        "name": "test menu3",
        "restaurant_id": 17177
      },
      {
        "created": "2020-07-19T13:12:26",
        "id": 2077,
        "name": "test menu4",
        "restaurant_id": 17177
      },
      {
        "created": "2020-07-19T13:12:26",
        "id": 2074,
        "name": "test menu1",
        "restaurant_id": 17177
      },
      {
        "created": "2020-07-19T13:12:26",
        "id": 2075,
        "name": "test menu2",
        "restaurant_id": 17177
      }
    ]
  }
}
```
#### → <ins>Message to server</ins>
* __Topic:__ restaurants:lobby
* __Event:__ change_menu_order
* __Body:__
```json
{
  "action": "to_bottom",
  "menu_id": 2077,
  "restaurant_id": 17177
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
        "created": "2020-07-19T13:12:26",
        "id": 2076,
        "name": "test menu3",
        "restaurant_id": 17177
      },
      {
        "created": "2020-07-19T13:12:26",
        "id": 2074,
        "name": "test menu1",
        "restaurant_id": 17177
      },
      {
        "created": "2020-07-19T13:12:26",
        "id": 2075,
        "name": "test menu2",
        "restaurant_id": 17177
      },
      {
        "created": "2020-07-19T13:12:26",
        "id": 2077,
        "name": "test menu4",
        "restaurant_id": 17177
      }
    ]
  }
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
  "email": "user-576460752303423134@example.com",
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
x-request-id: FiMphSVFrQBuoLcAAAEF
```
* __Response body:__
```json
{
  "success": {
    "email": "user-576460752303423134@example.com",
    "token": "XyoaUlbtsWtX1u4SWy1q88K9BrNrnSAB4rXpMi8z3VI="
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
x-request-id: FiMphScessBLQMgAAAGi
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
  "email": "user-576460752303423102@example.com",
  "password": "hello world!"
}
```

##### ← <ins>Response to you</ins>
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FiMphSVFrQBcmAwAAAEl
```
* __Response body:__
```json
{
  "success": {
    "token": "IhltifVv+gYbT3xYxvQKUcFFvmxjkdQbQR8U3sepayM="
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
  "email": "user-576460752303422876@example.com",
  "password": "lol"
}
```

##### ← <ins>Response to you</ins>
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FiMphScessCxZfYAAAKE
```
* __Response body:__
```json
{
  "error": "Fel användarnamn eller lösenord"
}
```

---
