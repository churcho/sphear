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
  "user_id": 33686
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
        "address": "trollvägen 279",
        "created": "2020-07-19T13:38:55",
        "id": 17278,
        "menus": [],
        "name": "restaurant 343",
        "url": "https://311.io"
      },
      {
        "address": "trollvägen 204",
        "created": "2020-07-19T13:38:55",
        "id": 17279,
        "menus": [],
        "name": "restaurant 268",
        "url": "https://236.io"
      },
      {
        "address": "trollvägen 108",
        "created": "2020-07-19T13:38:55",
        "id": 17280,
        "menus": [],
        "name": "restaurant 172",
        "url": "https://140.io"
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
  "restaurant_id": 17276
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "address": "trollvägen 599",
    "created": "2020-07-19T13:38:55",
    "id": 17276,
    "menus": [],
    "name": "restaurant 663",
    "url": "https://631.io"
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
  "restaurant_id": 17291
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
        "created": "2020-07-19T13:38:55",
        "id": 2113,
        "name": "test menu1",
        "restaurant_id": 17291
      },
      {
        "created": "2020-07-19T13:38:55",
        "id": 2114,
        "name": "test menu2",
        "restaurant_id": 17291
      },
      {
        "created": "2020-07-19T13:38:55",
        "id": 2115,
        "name": "test menu3",
        "restaurant_id": 17291
      },
      {
        "created": "2020-07-19T13:38:55",
        "id": 2116,
        "name": "test menu4",
        "restaurant_id": 17291
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
  "menu_id": 2111
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "created": "2020-07-19T13:38:55",
    "id": 2111,
    "name": "test menu1",
    "restaurant_id": 17287
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
    "created": "2020-07-19T13:38:56",
    "id": 17316,
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
    "created": "2020-07-19T13:38:56",
    "id": 17316,
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
  "restaurant_id": 17314
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "address": "trollvägen 876",
    "created": "2020-07-19T13:38:56",
    "id": 17314,
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
    "address": "trollvägen 876",
    "created": "2020-07-19T13:38:56",
    "id": 17314,
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
  "restaurant_id": 17310
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted restaurant 'restaurant 615' with id 17310"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ restaurants:lobby
* __Event:__ restaurant_deleted
* __Body:__
```json
{
  "message": "Deleted restaurant 'restaurant 615'",
  "restaurant_id": 17310
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
  "restaurant_id": 17294
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "created": "2020-07-19T13:38:55",
    "id": 2117,
    "name": "test menu",
    "restaurant_id": 17294
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
    "created": "2020-07-19T13:38:55",
    "id": 2117,
    "name": "test menu",
    "restaurant_id": 17294
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
  "menu_id": 2110,
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
    "created": "2020-07-19T13:38:55",
    "id": 2110,
    "name": "some new name",
    "restaurant_id": 17283
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
    "created": "2020-07-19T13:38:55",
    "id": 2110,
    "name": "some new name",
    "restaurant_id": 17283
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
  "menu_id": 2122
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted menu 'test menu1' with id 2122"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ restaurants:lobby
* __Event:__ menu_deleted
* __Body:__
```json
{
  "menu_id": 2122,
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
  "restaurant_id": 17298
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "address": "trollvägen 252",
    "created": "2020-07-19T13:38:55",
    "id": 17298,
    "menus": [
      {
        "id": 2118,
        "name": "test menu1"
      },
      {
        "id": 2119,
        "name": "test menu2"
      },
      {
        "id": 2120,
        "name": "test menu3"
      },
      {
        "id": 2121,
        "name": "test menu4"
      }
    ],
    "name": "restaurant 316",
    "url": "https://284.io"
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
  "menu_id": 2121,
  "restaurant_id": 17298
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
        "created": "2020-07-19T13:38:55",
        "id": 2118,
        "name": "test menu1",
        "restaurant_id": 17298
      },
      {
        "created": "2020-07-19T13:38:55",
        "id": 2121,
        "name": "test menu4",
        "restaurant_id": 17298
      },
      {
        "created": "2020-07-19T13:38:55",
        "id": 2119,
        "name": "test menu2",
        "restaurant_id": 17298
      },
      {
        "created": "2020-07-19T13:38:55",
        "id": 2120,
        "name": "test menu3",
        "restaurant_id": 17298
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
  "menu_id": 2120,
  "restaurant_id": 17298
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
        "created": "2020-07-19T13:38:55",
        "id": 2118,
        "name": "test menu1",
        "restaurant_id": 17298
      },
      {
        "created": "2020-07-19T13:38:55",
        "id": 2121,
        "name": "test menu4",
        "restaurant_id": 17298
      },
      {
        "created": "2020-07-19T13:38:55",
        "id": 2120,
        "name": "test menu3",
        "restaurant_id": 17298
      },
      {
        "created": "2020-07-19T13:38:55",
        "id": 2119,
        "name": "test menu2",
        "restaurant_id": 17298
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
  "menu_id": 2118,
  "restaurant_id": 17298
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
        "created": "2020-07-19T13:38:55",
        "id": 2121,
        "name": "test menu4",
        "restaurant_id": 17298
      },
      {
        "created": "2020-07-19T13:38:55",
        "id": 2118,
        "name": "test menu1",
        "restaurant_id": 17298
      },
      {
        "created": "2020-07-19T13:38:55",
        "id": 2120,
        "name": "test menu3",
        "restaurant_id": 17298
      },
      {
        "created": "2020-07-19T13:38:55",
        "id": 2119,
        "name": "test menu2",
        "restaurant_id": 17298
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
  "menu_id": 2120,
  "restaurant_id": 17298
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
        "created": "2020-07-19T13:38:55",
        "id": 2120,
        "name": "test menu3",
        "restaurant_id": 17298
      },
      {
        "created": "2020-07-19T13:38:55",
        "id": 2121,
        "name": "test menu4",
        "restaurant_id": 17298
      },
      {
        "created": "2020-07-19T13:38:55",
        "id": 2118,
        "name": "test menu1",
        "restaurant_id": 17298
      },
      {
        "created": "2020-07-19T13:38:55",
        "id": 2119,
        "name": "test menu2",
        "restaurant_id": 17298
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
  "menu_id": 2121,
  "restaurant_id": 17298
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
        "created": "2020-07-19T13:38:55",
        "id": 2120,
        "name": "test menu3",
        "restaurant_id": 17298
      },
      {
        "created": "2020-07-19T13:38:55",
        "id": 2118,
        "name": "test menu1",
        "restaurant_id": 17298
      },
      {
        "created": "2020-07-19T13:38:55",
        "id": 2119,
        "name": "test menu2",
        "restaurant_id": 17298
      },
      {
        "created": "2020-07-19T13:38:55",
        "id": 2121,
        "name": "test menu4",
        "restaurant_id": 17298
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
  "email": "user-576460752303421406@example.com",
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
x-request-id: FiMq9zfQsUBuoLcAAANF
```
* __Response body:__
```json
{
  "success": {
    "email": "user-576460752303421406@example.com",
    "token": "FSDprrc+GRLIp+O2ey7Y0tCSsTW6aSmHG386IVt/Jho="
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
x-request-id: FiMq9zqd2wCxZfYAAAhC
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
  "email": "user-576460752303422047@example.com",
  "password": "hello world!"
}
```

##### ← <ins>Response to you</ins>
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FiMq9zfQsUBcmAwAAAXB
```
* __Response body:__
```json
{
  "success": {
    "token": "J2Nb46EWUXXyjz0S5O3qZdPXMwApw+6pnu8Si8a4iMA="
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
  "email": "user-576460752303421983@example.com",
  "password": "lol"
}
```

##### ← <ins>Response to you</ins>
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FiMq9zqd2wB3YwcAAAKG
```
* __Response body:__
```json
{
  "error": "Fel användarnamn eller lösenord"
}
```

---
