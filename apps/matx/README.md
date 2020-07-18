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


  * [channel menus:lobby](#channel-menus-lobby)
    * [guest actions - ping](#channel-menus-lobby-guest-actions-ping)
    * [guest actions - get all menus from a restaurant](#channel-menus-lobby-guest-actions-get-all-menus-from-a-restaurant)
    * [guest actions - get one menu](#channel-menus-lobby-guest-actions-get-one-menu)
    * [user actions - ensure logged in correctly](#channel-menus-lobby-user-actions-ensure-logged-in-correctly)
    * [user actions - create a menu](#channel-menus-lobby-user-actions-create-a-menu)
    * [user actions - edit a menu](#channel-menus-lobby-user-actions-edit-a-menu)
    * [user actions - delete a menu](#channel-menus-lobby-user-actions-delete-a-menu)
    * [user actions - change order of menu](#channel-menus-lobby-user-actions-change-order-of-menu)
  * [channel restaurants:lobby](#channel-restaurants-lobby)
    * [guest actions - ping](#channel-restaurants-lobby-guest-actions-ping)
    * [guest actions - get all restaurants](#channel-restaurants-lobby-guest-actions-get-all-restaurants)
    * [guest actions - get one restaurant](#channel-restaurants-lobby-guest-actions-get-one-restaurant)
    * [user actions - ensure logged in correctly](#channel-restaurants-lobby-user-actions-ensure-logged-in-correctly)
    * [user actions - create a restaurant](#channel-restaurants-lobby-user-actions-create-a-restaurant)
    * [user actions - edit a restaurant](#channel-restaurants-lobby-user-actions-edit-a-restaurant)
    * [user actions - delete a restaurant](#channel-restaurants-lobby-user-actions-delete-a-restaurant)
  * [(REST) Register account](#rest-register-account)
    * [rest-register-account-create](#rest-register-account-create)
  * [(REST) Login account](#rest-login-account)
    * [rest-login-account-create](#rest-login-account-create)

# <a id=channel-menus-lobby></a>channel menus:lobby
## <a id=channel-menus-lobby-guest-actions-ping></a>guest actions - ping
#### → <ins>Message to server</ins>
* __Topic:__ menus:lobby
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
## <a id=channel-menus-lobby-guest-actions-get-all-menus-from-a-restaurant></a>guest actions - get all menus from a restaurant
#### → <ins>Message to server</ins>
* __Topic:__ menus:lobby
* __Event:__ get
* __Body:__
```json
{
  "restaurant_id": 14325
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
        "created": "2020-07-18T00:38:32",
        "id": 1231,
        "name": "test menu1",
        "restaurant_id": 14325
      },
      {
        "created": "2020-07-18T00:38:32",
        "id": 1232,
        "name": "test menu2",
        "restaurant_id": 14325
      },
      {
        "created": "2020-07-18T00:38:32",
        "id": 1233,
        "name": "test menu3",
        "restaurant_id": 14325
      }
    ]
  }
}
```
---
## <a id=channel-menus-lobby-guest-actions-get-one-menu></a>guest actions - get one menu
#### → <ins>Message to server</ins>
* __Topic:__ menus:lobby
* __Event:__ get
* __Body:__
```json
{
  "menu_id": 1224
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "created": "2020-07-18T00:38:32",
    "id": 1224,
    "name": "test menu1",
    "restaurant_id": 14313
  }
}
```
---
## <a id=channel-menus-lobby-user-actions-ensure-logged-in-correctly></a>user actions - ensure logged in correctly
#### → <ins>Message to server</ins>
* __Topic:__ menus:lobby
* __Event:__ logged_in
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "user_id": 30895
}
```
---
## <a id=channel-menus-lobby-user-actions-create-a-menu></a>user actions - create a menu
#### → <ins>Message to server</ins>
* __Topic:__ menus:lobby
* __Event:__ create
* __Body:__
```json
{
  "name": "test menu",
  "restaurant_id": 14330
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "created": "2020-07-18T00:38:33",
    "id": 1235,
    "name": "test menu",
    "restaurant_id": 14330
  }
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ menus:lobby
* __Event:__ menu_created
* __Body:__
```json
{
  "data": {
    "created": "2020-07-18T00:38:33",
    "id": 1235,
    "name": "test menu",
    "restaurant_id": 14330
  }
}
```
---
## <a id=channel-menus-lobby-user-actions-edit-a-menu></a>user actions - edit a menu
#### → <ins>Message to server</ins>
* __Topic:__ menus:lobby
* __Event:__ update
* __Body:__
```json
{
  "id": 1229,
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
    "created": "2020-07-18T00:38:32",
    "id": 1229,
    "name": "some new name",
    "restaurant_id": 14319
  }
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ menus:lobby
* __Event:__ menu_updated
* __Body:__
```json
{
  "data": {
    "created": "2020-07-18T00:38:32",
    "id": 1229,
    "name": "some new name",
    "restaurant_id": 14319
  }
}
```
---
## <a id=channel-menus-lobby-user-actions-delete-a-menu></a>user actions - delete a menu
#### → <ins>Message to server</ins>
* __Topic:__ menus:lobby
* __Event:__ delete
* __Body:__
```json
{
  "id": 1230
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted menu 'test menu1' with id 1230"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ menus:lobby
* __Event:__ menu_deleted
* __Body:__
```json
{
  "id": 1230,
  "message": "Deleted menu 'test menu1'"
}
```
---
## <a id=channel-menus-lobby-user-actions-change-order-of-menu></a>user actions - change order of menu
#### → <ins>Message to server</ins>
* __Topic:__ menus:lobby
* __Event:__ change_menu_order
* __Body:__
```json
{
  "action": "insert",
  "insert": 2,
  "menu_id": 1228,
  "restaurant_id": 14316
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
        "created": "2020-07-18T00:38:32",
        "id": 1225,
        "name": "test menu1",
        "restaurant_id": 14316
      },
      {
        "created": "2020-07-18T00:38:32",
        "id": 1228,
        "name": "test menu4",
        "restaurant_id": 14316
      },
      {
        "created": "2020-07-18T00:38:32",
        "id": 1226,
        "name": "test menu2",
        "restaurant_id": 14316
      },
      {
        "created": "2020-07-18T00:38:32",
        "id": 1227,
        "name": "test menu3",
        "restaurant_id": 14316
      }
    ]
  }
}
```
#### → <ins>Message to server</ins>
* __Topic:__ menus:lobby
* __Event:__ change_menu_order
* __Body:__
```json
{
  "action": "higher",
  "menu_id": 1227,
  "restaurant_id": 14316
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
        "created": "2020-07-18T00:38:32",
        "id": 1225,
        "name": "test menu1",
        "restaurant_id": 14316
      },
      {
        "created": "2020-07-18T00:38:32",
        "id": 1227,
        "name": "test menu3",
        "restaurant_id": 14316
      },
      {
        "created": "2020-07-18T00:38:32",
        "id": 1226,
        "name": "test menu2",
        "restaurant_id": 14316
      },
      {
        "created": "2020-07-18T00:38:32",
        "id": 1228,
        "name": "test menu4",
        "restaurant_id": 14316
      }
    ]
  }
}
```
#### → <ins>Message to server</ins>
* __Topic:__ menus:lobby
* __Event:__ change_menu_order
* __Body:__
```json
{
  "action": "lower",
  "menu_id": 1225,
  "restaurant_id": 14316
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
        "created": "2020-07-18T00:38:32",
        "id": 1226,
        "name": "test menu2",
        "restaurant_id": 14316
      },
      {
        "created": "2020-07-18T00:38:32",
        "id": 1225,
        "name": "test menu1",
        "restaurant_id": 14316
      },
      {
        "created": "2020-07-18T00:38:32",
        "id": 1227,
        "name": "test menu3",
        "restaurant_id": 14316
      },
      {
        "created": "2020-07-18T00:38:32",
        "id": 1228,
        "name": "test menu4",
        "restaurant_id": 14316
      }
    ]
  }
}
```
#### → <ins>Message to server</ins>
* __Topic:__ menus:lobby
* __Event:__ change_menu_order
* __Body:__
```json
{
  "action": "to_top",
  "menu_id": 1227,
  "restaurant_id": 14316
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
        "created": "2020-07-18T00:38:32",
        "id": 1227,
        "name": "test menu3",
        "restaurant_id": 14316
      },
      {
        "created": "2020-07-18T00:38:32",
        "id": 1225,
        "name": "test menu1",
        "restaurant_id": 14316
      },
      {
        "created": "2020-07-18T00:38:32",
        "id": 1226,
        "name": "test menu2",
        "restaurant_id": 14316
      },
      {
        "created": "2020-07-18T00:38:32",
        "id": 1228,
        "name": "test menu4",
        "restaurant_id": 14316
      }
    ]
  }
}
```
#### → <ins>Message to server</ins>
* __Topic:__ menus:lobby
* __Event:__ change_menu_order
* __Body:__
```json
{
  "action": "to_bottom",
  "menu_id": 1226,
  "restaurant_id": 14316
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
        "created": "2020-07-18T00:38:32",
        "id": 1225,
        "name": "test menu1",
        "restaurant_id": 14316
      },
      {
        "created": "2020-07-18T00:38:32",
        "id": 1227,
        "name": "test menu3",
        "restaurant_id": 14316
      },
      {
        "created": "2020-07-18T00:38:32",
        "id": 1228,
        "name": "test menu4",
        "restaurant_id": 14316
      },
      {
        "created": "2020-07-18T00:38:32",
        "id": 1226,
        "name": "test menu2",
        "restaurant_id": 14316
      }
    ]
  }
}
```
---
# <a id=channel-restaurants-lobby></a>channel restaurants:lobby
## <a id=channel-restaurants-lobby-guest-actions-ping></a>guest actions - ping
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
## <a id=channel-restaurants-lobby-guest-actions-get-all-restaurants></a>guest actions - get all restaurants
#### → <ins>Message to server</ins>
* __Topic:__ restaurants:lobby
* __Event:__ get
* __Body:__
```json
{
  "id": "all"
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "restaurants": [
      {
        "address": "trollvägen 990",
        "created": "2020-07-18T00:38:33",
        "id": 14345,
        "menus": [],
        "name": "restaurant 054",
        "url": "https://022.io"
      },
      {
        "address": "trollvägen 127",
        "created": "2020-07-18T00:38:33",
        "id": 14346,
        "menus": [],
        "name": "restaurant 191",
        "url": "https://159.io"
      },
      {
        "address": "trollvägen 031",
        "created": "2020-07-18T00:38:33",
        "id": 14347,
        "menus": [],
        "name": "restaurant 095",
        "url": "https://063.io"
      }
    ]
  }
}
```
---
## <a id=channel-restaurants-lobby-guest-actions-get-one-restaurant></a>guest actions - get one restaurant
#### → <ins>Message to server</ins>
* __Topic:__ restaurants:lobby
* __Event:__ get
* __Body:__
```json
{
  "id": 14357
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "address": "trollvägen 636",
    "created": "2020-07-18T00:38:33",
    "id": 14357,
    "menus": [],
    "name": "restaurant 700",
    "url": "https://668.io"
  }
}
```
---
## <a id=channel-restaurants-lobby-user-actions-ensure-logged-in-correctly></a>user actions - ensure logged in correctly
#### → <ins>Message to server</ins>
* __Topic:__ restaurants:lobby
* __Event:__ logged_in
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "user_id": 30907
}
```
---
## <a id=channel-restaurants-lobby-user-actions-create-a-restaurant></a>user actions - create a restaurant
#### → <ins>Message to server</ins>
* __Topic:__ restaurants:lobby
* __Event:__ create
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
    "created": "2020-07-18T00:38:33",
    "id": 14337,
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
    "created": "2020-07-18T00:38:33",
    "id": 14337,
    "menus": [],
    "name": "test",
    "url": "some url"
  }
}
```
---
## <a id=channel-restaurants-lobby-user-actions-edit-a-restaurant></a>user actions - edit a restaurant
#### → <ins>Message to server</ins>
* __Topic:__ restaurants:lobby
* __Event:__ update
* __Body:__
```json
{
  "id": 14349,
  "params": {
    "name": "new name",
    "url": "new url"
  }
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "address": "trollvägen 724",
    "created": "2020-07-18T00:38:33",
    "id": 14349,
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
    "address": "trollvägen 724",
    "created": "2020-07-18T00:38:33",
    "id": 14349,
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
* __Event:__ delete
* __Body:__
```json
{
  "id": 14342
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted restaurant 'restaurant 204' with id 14342"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ restaurants:lobby
* __Event:__ restaurant_deleted
* __Body:__
```json
{
  "id": 14342,
  "message": "Deleted restaurant 'restaurant 204'"
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
  "email": "user-576460752303421981@example.com",
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
x-request-id: FiKxzOF7q0ChQM8AAAYD
```
* __Response body:__
```json
{
  "success": {
    "email": "user-576460752303421981@example.com",
    "token": "EwjZlL1wOAdYlAJCtNw+fsVRgQl4OF4La8tD1AVQro4="
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
x-request-id: FiKxzNzVe8BcmAwAAACE
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
  "email": "user-576460752303421983@example.com",
  "password": "hello world!"
}
```

##### ← <ins>Response to you</ins>
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FiKxzOF7q0D8j9QAAAYB
```
* __Response body:__
```json
{
  "success": {
    "token": "p69iYu49WW6nk/t3mcDZ0pI2m/DQkLdq5ADSA1X67js="
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
  "email": "user-576460752303422015@example.com",
  "password": "lol"
}
```

##### ← <ins>Response to you</ins>
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FiKxzNzVe8CxZfYAAABk
```
* __Response body:__
```json
{
  "error": "Fel användarnamn eller lösenord"
}
```

---
