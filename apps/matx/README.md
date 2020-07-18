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
  "restaurant_id": 15140
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
        "created": "2020-07-18T01:33:54",
        "id": 1457,
        "name": "test menu1",
        "restaurant_id": 15140
      },
      {
        "created": "2020-07-18T01:33:54",
        "id": 1458,
        "name": "test menu2",
        "restaurant_id": 15140
      },
      {
        "created": "2020-07-18T01:33:54",
        "id": 1459,
        "name": "test menu3",
        "restaurant_id": 15140
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
  "menu_id": 1469
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "created": "2020-07-18T01:33:54",
    "id": 1469,
    "name": "test menu1",
    "restaurant_id": 15160
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
  "user_id": 31636
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
  "restaurant_id": 15149
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "created": "2020-07-18T01:33:54",
    "id": 1463,
    "name": "test menu",
    "restaurant_id": 15149
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
    "created": "2020-07-18T01:33:54",
    "id": 1463,
    "name": "test menu",
    "restaurant_id": 15149
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
  "id": 1461,
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
    "created": "2020-07-18T01:33:54",
    "id": 1461,
    "name": "some new name",
    "restaurant_id": 15144
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
    "created": "2020-07-18T01:33:54",
    "id": 1461,
    "name": "some new name",
    "restaurant_id": 15144
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
  "id": 1460
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted menu 'test menu1' with id 1460"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ menus:lobby
* __Event:__ menu_deleted
* __Body:__
```json
{
  "id": 1460,
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
  "restaurant_id": 15152
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
        "created": "2020-07-18T01:33:54",
        "id": 1464,
        "name": "test menu1",
        "restaurant_id": 15152
      },
      {
        "created": "2020-07-18T01:33:54",
        "id": 1465,
        "name": "test menu2",
        "restaurant_id": 15152
      },
      {
        "created": "2020-07-18T01:33:54",
        "id": 1466,
        "name": "test menu3",
        "restaurant_id": 15152
      },
      {
        "created": "2020-07-18T01:33:54",
        "id": 1467,
        "name": "test menu4",
        "restaurant_id": 15152
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
  "index": 0,
  "menu_id": 1467,
  "restaurant_id": 15152
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
        "created": "2020-07-18T01:33:54",
        "id": 1467,
        "name": "test menu4",
        "restaurant_id": 15152
      },
      {
        "created": "2020-07-18T01:33:54",
        "id": 1464,
        "name": "test menu1",
        "restaurant_id": 15152
      },
      {
        "created": "2020-07-18T01:33:54",
        "id": 1465,
        "name": "test menu2",
        "restaurant_id": 15152
      },
      {
        "created": "2020-07-18T01:33:54",
        "id": 1466,
        "name": "test menu3",
        "restaurant_id": 15152
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
  "menu_id": 1466,
  "restaurant_id": 15152
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
        "created": "2020-07-18T01:33:54",
        "id": 1464,
        "name": "test menu1",
        "restaurant_id": 15152
      },
      {
        "created": "2020-07-18T01:33:54",
        "id": 1466,
        "name": "test menu3",
        "restaurant_id": 15152
      },
      {
        "created": "2020-07-18T01:33:54",
        "id": 1465,
        "name": "test menu2",
        "restaurant_id": 15152
      },
      {
        "created": "2020-07-18T01:33:54",
        "id": 1467,
        "name": "test menu4",
        "restaurant_id": 15152
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
  "menu_id": 1464,
  "restaurant_id": 15152
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
        "created": "2020-07-18T01:33:54",
        "id": 1465,
        "name": "test menu2",
        "restaurant_id": 15152
      },
      {
        "created": "2020-07-18T01:33:54",
        "id": 1464,
        "name": "test menu1",
        "restaurant_id": 15152
      },
      {
        "created": "2020-07-18T01:33:54",
        "id": 1466,
        "name": "test menu3",
        "restaurant_id": 15152
      },
      {
        "created": "2020-07-18T01:33:54",
        "id": 1467,
        "name": "test menu4",
        "restaurant_id": 15152
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
  "menu_id": 1466,
  "restaurant_id": 15152
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
        "created": "2020-07-18T01:33:54",
        "id": 1466,
        "name": "test menu3",
        "restaurant_id": 15152
      },
      {
        "created": "2020-07-18T01:33:54",
        "id": 1464,
        "name": "test menu1",
        "restaurant_id": 15152
      },
      {
        "created": "2020-07-18T01:33:54",
        "id": 1465,
        "name": "test menu2",
        "restaurant_id": 15152
      },
      {
        "created": "2020-07-18T01:33:54",
        "id": 1467,
        "name": "test menu4",
        "restaurant_id": 15152
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
  "menu_id": 1465,
  "restaurant_id": 15152
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
        "created": "2020-07-18T01:33:54",
        "id": 1464,
        "name": "test menu1",
        "restaurant_id": 15152
      },
      {
        "created": "2020-07-18T01:33:54",
        "id": 1466,
        "name": "test menu3",
        "restaurant_id": 15152
      },
      {
        "created": "2020-07-18T01:33:54",
        "id": 1467,
        "name": "test menu4",
        "restaurant_id": 15152
      },
      {
        "created": "2020-07-18T01:33:54",
        "id": 1465,
        "name": "test menu2",
        "restaurant_id": 15152
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
        "address": "trollvägen 524",
        "created": "2020-07-18T01:33:55",
        "id": 15187,
        "menus": [],
        "name": "restaurant 588",
        "url": "https://556.io"
      },
      {
        "address": "trollvägen 995",
        "created": "2020-07-18T01:33:55",
        "id": 15188,
        "menus": [],
        "name": "restaurant 059",
        "url": "https://027.io"
      },
      {
        "address": "trollvägen 899",
        "created": "2020-07-18T01:33:55",
        "id": 15189,
        "menus": [],
        "name": "restaurant 963",
        "url": "https://931.io"
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
  "id": 15182
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "address": "trollvägen 164",
    "created": "2020-07-18T01:33:55",
    "id": 15182,
    "menus": [],
    "name": "restaurant 228",
    "url": "https://196.io"
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
  "user_id": 31647
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
    "created": "2020-07-18T01:33:54",
    "id": 15166,
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
    "created": "2020-07-18T01:33:54",
    "id": 15166,
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
  "id": 15170,
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
    "address": "trollvägen 092",
    "created": "2020-07-18T01:33:54",
    "id": 15170,
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
    "address": "trollvägen 092",
    "created": "2020-07-18T01:33:54",
    "id": 15170,
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
  "id": 15177
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted restaurant 'restaurant 603' with id 15177"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ restaurants:lobby
* __Event:__ restaurant_deleted
* __Body:__
```json
{
  "id": 15177,
  "message": "Deleted restaurant 'restaurant 603'"
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
  "email": "user-576460752303423481@example.com",
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
x-request-id: FiK00lT0OAA7bFQAAAAn
```
* __Response body:__
```json
{
  "success": {
    "email": "user-576460752303423481@example.com",
    "token": "CjthjWwokSEDH4gy95sra5U+Q1keqkAQ4WtbOCXLX1Y="
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
x-request-id: FiK00lInDkDpE5oAAAGE
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
  "email": "user-576460752303423068@example.com",
  "password": "hello world!"
}
```

##### ← <ins>Response to you</ins>
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FiK00lT0OAD8j9QAAAHE
```
* __Response body:__
```json
{
  "success": {
    "token": "SmhONTxabk2gHn95/q7z3wUKqnzZT2BnNBAxIJS2AdY="
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
  "email": "user-576460752303423164@example.com",
  "password": "lol"
}
```

##### ← <ins>Response to you</ins>
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FiK00lInDkB3YwcAAAFk
```
* __Response body:__
```json
{
  "error": "Fel användarnamn eller lösenord"
}
```

---
