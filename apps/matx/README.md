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
    * [user actions - change sequence of menu](#channel-restaurants-lobby-user-actions-change-sequence-of-menu)
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
  "user_id": 33908
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
        "address": "trollvägen 733",
        "created": "2020-07-19T18:05:17",
        "id": 17517,
        "menus": [],
        "name": "restaurant 797",
        "url": "https://765.io"
      },
      {
        "address": "trollvägen 583",
        "created": "2020-07-19T18:05:17",
        "id": 17518,
        "menus": [],
        "name": "restaurant 647",
        "url": "https://615.io"
      },
      {
        "address": "trollvägen 487",
        "created": "2020-07-19T18:05:17",
        "id": 17519,
        "menus": [],
        "name": "restaurant 551",
        "url": "https://519.io"
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
  "restaurant_id": 17540
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "address": "trollvägen 422",
    "created": "2020-07-19T18:05:17",
    "id": 17540,
    "menus": [],
    "name": "restaurant 486",
    "url": "https://454.io"
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
  "restaurant_id": 17512
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
        "id": 2191,
        "name": "test menu1"
      },
      {
        "id": 2192,
        "name": "test menu2"
      },
      {
        "id": 2193,
        "name": "test menu3"
      },
      {
        "id": 2194,
        "name": "test menu4"
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
  "menu_id": 2198
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "id": 2198,
    "name": "test menu1"
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
    "created": "2020-07-19T18:05:17",
    "id": 17535,
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
    "created": "2020-07-19T18:05:17",
    "id": 17535,
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
  "restaurant_id": 17533
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "address": "trollvägen 998",
    "created": "2020-07-19T18:05:17",
    "id": 17533,
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
    "address": "trollvägen 998",
    "created": "2020-07-19T18:05:17",
    "id": 17533,
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
  "restaurant_id": 17509
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted restaurant 'restaurant 245' with id 17509"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ restaurants:lobby
* __Event:__ restaurant_deleted
* __Body:__
```json
{
  "message": "Deleted restaurant 'restaurant 245'",
  "restaurant_id": 17509
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
  "restaurant_id": 17504
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "id": 2190,
    "name": "test menu"
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
    "id": 2190,
    "name": "test menu"
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
  "menu_id": 2196,
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
    "id": 2196,
    "name": "some new name"
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
    "id": 2196,
    "name": "some new name"
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
  "menu_id": 2197
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted menu 'test menu1' with id 2197"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ restaurants:lobby
* __Event:__ menu_deleted
* __Body:__
```json
{
  "menu_id": 2197,
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
  "restaurant_id": 17501
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "address": "trollvägen 598",
    "created": "2020-07-19T18:05:16",
    "id": 17501,
    "menus": [
      {
        "id": 2186,
        "name": "test menu1"
      },
      {
        "id": 2187,
        "name": "test menu2"
      },
      {
        "id": 2188,
        "name": "test menu3"
      },
      {
        "id": 2189,
        "name": "test menu4"
      }
    ],
    "name": "restaurant 662",
    "url": "https://630.io"
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
  "menu_id": 2189,
  "restaurant_id": 17501
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
        "id": 2186,
        "name": "test menu1"
      },
      {
        "id": 2189,
        "name": "test menu4"
      },
      {
        "id": 2187,
        "name": "test menu2"
      },
      {
        "id": 2188,
        "name": "test menu3"
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
  "menu_id": 2188,
  "restaurant_id": 17501
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
        "id": 2186,
        "name": "test menu1"
      },
      {
        "id": 2189,
        "name": "test menu4"
      },
      {
        "id": 2188,
        "name": "test menu3"
      },
      {
        "id": 2187,
        "name": "test menu2"
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
  "menu_id": 2186,
  "restaurant_id": 17501
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
        "id": 2189,
        "name": "test menu4"
      },
      {
        "id": 2186,
        "name": "test menu1"
      },
      {
        "id": 2188,
        "name": "test menu3"
      },
      {
        "id": 2187,
        "name": "test menu2"
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
  "menu_id": 2188,
  "restaurant_id": 17501
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
        "id": 2188,
        "name": "test menu3"
      },
      {
        "id": 2189,
        "name": "test menu4"
      },
      {
        "id": 2186,
        "name": "test menu1"
      },
      {
        "id": 2187,
        "name": "test menu2"
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
  "menu_id": 2189,
  "restaurant_id": 17501
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
        "id": 2188,
        "name": "test menu3"
      },
      {
        "id": 2186,
        "name": "test menu1"
      },
      {
        "id": 2187,
        "name": "test menu2"
      },
      {
        "id": 2189,
        "name": "test menu4"
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
  "email": "user-576460752303423482@example.com",
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
x-request-id: FiM5gEDqlMDbwzAAAAAm
```
* __Response body:__
```json
{
  "success": {
    "email": "user-576460752303423482@example.com",
    "token": "JII4oRy9xSYs+o5imb7R0bpubEgAbuPdzvJRjQJgZuw="
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
x-request-id: FiM5gD4dawChQM8AAAVC
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
  "email": "user-576460752303422110@example.com",
  "password": "hello world!"
}
```

##### ← <ins>Response to you</ins>
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FiM5gEHPdoD_ZKcAAAJl
```
* __Response body:__
```json
{
  "success": {
    "token": "XcT8HGSY87H72CEDC7ymkA39i+okdb3VsapL85Y9ycg="
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
  "email": "user-576460752303421183@example.com",
  "password": "lol"
}
```

##### ← <ins>Response to you</ins>
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FiM5gD4dawBhzi4AAAkh
```
* __Response body:__
```json
{
  "error": "Fel användarnamn eller lösenord"
}
```

---
