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
  "restaurant_id": 16370
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
        "created": "2020-07-18T11:11:02",
        "id": 1809,
        "name": "test menu1",
        "restaurant_id": 16370
      },
      {
        "created": "2020-07-18T11:11:02",
        "id": 1810,
        "name": "test menu2",
        "restaurant_id": 16370
      },
      {
        "created": "2020-07-18T11:11:02",
        "id": 1811,
        "name": "test menu3",
        "restaurant_id": 16370
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
  "menu_id": 1812
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "created": "2020-07-18T11:11:02",
    "id": 1812,
    "name": "test menu1",
    "restaurant_id": 16375
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
  "user_id": 32810
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
  "restaurant_id": 16393
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "created": "2020-07-18T11:11:03",
    "id": 1819,
    "name": "test menu",
    "restaurant_id": 16393
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
    "created": "2020-07-18T11:11:03",
    "id": 1819,
    "name": "test menu",
    "restaurant_id": 16393
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
  "id": 1821,
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
    "created": "2020-07-18T11:11:03",
    "id": 1821,
    "name": "some new name",
    "restaurant_id": 16397
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
    "created": "2020-07-18T11:11:03",
    "id": 1821,
    "name": "some new name",
    "restaurant_id": 16397
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
  "id": 1813
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted menu 'test menu1' with id 1813"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ menus:lobby
* __Event:__ menu_deleted
* __Body:__
```json
{
  "id": 1813,
  "message": "Deleted menu 'test menu1'"
}
```
---
## <a id=channel-menus-lobby-user-actions-change-order-of-menu></a>user actions - change order of menu
#### → <ins>Message to server</ins>
* __Topic:__ menus:lobby
* __Event:__ get
* __Body:__
```json
{
  "restaurant_id": 16385
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
        "created": "2020-07-18T11:11:02",
        "id": 1815,
        "name": "test menu1",
        "restaurant_id": 16385
      },
      {
        "created": "2020-07-18T11:11:02",
        "id": 1816,
        "name": "test menu2",
        "restaurant_id": 16385
      },
      {
        "created": "2020-07-18T11:11:02",
        "id": 1817,
        "name": "test menu3",
        "restaurant_id": 16385
      },
      {
        "created": "2020-07-18T11:11:02",
        "id": 1818,
        "name": "test menu4",
        "restaurant_id": 16385
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
  "action": "insert_at_index",
  "index": 1,
  "menu_id": 1818,
  "restaurant_id": 16385
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
        "created": "2020-07-18T11:11:02",
        "id": 1815,
        "name": "test menu1",
        "restaurant_id": 16385
      },
      {
        "created": "2020-07-18T11:11:02",
        "id": 1818,
        "name": "test menu4",
        "restaurant_id": 16385
      },
      {
        "created": "2020-07-18T11:11:02",
        "id": 1816,
        "name": "test menu2",
        "restaurant_id": 16385
      },
      {
        "created": "2020-07-18T11:11:02",
        "id": 1817,
        "name": "test menu3",
        "restaurant_id": 16385
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
  "menu_id": 1817,
  "restaurant_id": 16385
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
        "created": "2020-07-18T11:11:02",
        "id": 1815,
        "name": "test menu1",
        "restaurant_id": 16385
      },
      {
        "created": "2020-07-18T11:11:02",
        "id": 1818,
        "name": "test menu4",
        "restaurant_id": 16385
      },
      {
        "created": "2020-07-18T11:11:02",
        "id": 1817,
        "name": "test menu3",
        "restaurant_id": 16385
      },
      {
        "created": "2020-07-18T11:11:02",
        "id": 1816,
        "name": "test menu2",
        "restaurant_id": 16385
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
  "menu_id": 1815,
  "restaurant_id": 16385
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
        "created": "2020-07-18T11:11:02",
        "id": 1818,
        "name": "test menu4",
        "restaurant_id": 16385
      },
      {
        "created": "2020-07-18T11:11:02",
        "id": 1815,
        "name": "test menu1",
        "restaurant_id": 16385
      },
      {
        "created": "2020-07-18T11:11:02",
        "id": 1817,
        "name": "test menu3",
        "restaurant_id": 16385
      },
      {
        "created": "2020-07-18T11:11:02",
        "id": 1816,
        "name": "test menu2",
        "restaurant_id": 16385
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
  "menu_id": 1817,
  "restaurant_id": 16385
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
        "created": "2020-07-18T11:11:02",
        "id": 1817,
        "name": "test menu3",
        "restaurant_id": 16385
      },
      {
        "created": "2020-07-18T11:11:02",
        "id": 1818,
        "name": "test menu4",
        "restaurant_id": 16385
      },
      {
        "created": "2020-07-18T11:11:02",
        "id": 1815,
        "name": "test menu1",
        "restaurant_id": 16385
      },
      {
        "created": "2020-07-18T11:11:02",
        "id": 1816,
        "name": "test menu2",
        "restaurant_id": 16385
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
  "menu_id": 1818,
  "restaurant_id": 16385
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
        "created": "2020-07-18T11:11:02",
        "id": 1817,
        "name": "test menu3",
        "restaurant_id": 16385
      },
      {
        "created": "2020-07-18T11:11:02",
        "id": 1815,
        "name": "test menu1",
        "restaurant_id": 16385
      },
      {
        "created": "2020-07-18T11:11:02",
        "id": 1816,
        "name": "test menu2",
        "restaurant_id": 16385
      },
      {
        "created": "2020-07-18T11:11:02",
        "id": 1818,
        "name": "test menu4",
        "restaurant_id": 16385
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
        "address": "trollvägen 087",
        "created": "2020-07-18T11:11:03",
        "id": 16417,
        "menus": [],
        "name": "restaurant 151",
        "url": "https://119.io"
      },
      {
        "address": "trollvägen 927",
        "created": "2020-07-18T11:11:03",
        "id": 16418,
        "menus": [],
        "name": "restaurant 991",
        "url": "https://959.io"
      },
      {
        "address": "trollvägen 831",
        "created": "2020-07-18T11:11:03",
        "id": 16419,
        "menus": [],
        "name": "restaurant 895",
        "url": "https://863.io"
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
  "id": 16410
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "address": "trollvägen 411",
    "created": "2020-07-18T11:11:03",
    "id": 16410,
    "menus": [],
    "name": "restaurant 475",
    "url": "https://443.io"
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
  "user_id": 32818
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
    "created": "2020-07-18T11:11:03",
    "id": 16416,
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
    "created": "2020-07-18T11:11:03",
    "id": 16416,
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
  "id": 16403,
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
    "address": "trollvägen 726",
    "created": "2020-07-18T11:11:03",
    "id": 16403,
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
    "address": "trollvägen 726",
    "created": "2020-07-18T11:11:03",
    "id": 16403,
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
  "id": 16412
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted restaurant 'restaurant 695' with id 16412"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ restaurants:lobby
* __Event:__ restaurant_deleted
* __Body:__
```json
{
  "id": 16412,
  "message": "Deleted restaurant 'restaurant 695'"
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
  "email": "user-576460752303423258@example.com",
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
x-request-id: FiLUUOgJt4A7bFQAAAEG
```
* __Response body:__
```json
{
  "success": {
    "email": "user-576460752303423258@example.com",
    "token": "cY+tCAiT+uiA8eye4cffFON1MadYZ3ajreTUjdHRF0Q="
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
x-request-id: FiLUUOU8jcDpE5oAAAKi
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
  "email": "user-576460752303422782@example.com",
  "password": "hello world!"
}
```

##### ← <ins>Response to you</ins>
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FiLUUOgJt4D8j9QAAALi
```
* __Response body:__
```json
{
  "success": {
    "token": "u9iaY2k4my85/oBnkIV7Os3ddXkzA9m4vKGfkOowM80="
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
  "email": "user-576460752303422878@example.com",
  "password": "lol"
}
```

##### ← <ins>Response to you</ins>
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FiLUUOU8jcB3YwcAAAKC
```
* __Response body:__
```json
{
  "error": "Fel användarnamn eller lösenord"
}
```

---
