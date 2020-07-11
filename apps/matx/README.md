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


  * [channel restaurants](#channel-restaurants)
    * [guest actions - ping](#channel-restaurants-guest-actions-ping)
    * [guest actions - get all restaurants](#channel-restaurants-guest-actions-get-all-restaurants)
    * [guest actions - get one restaurant](#channel-restaurants-guest-actions-get-one-restaurant)
    * [user actions - ensure logged in correctly](#channel-restaurants-user-actions-ensure-logged-in-correctly)
    * [user actions - create a restaurant](#channel-restaurants-user-actions-create-a-restaurant)
    * [user actions - edit a restaurant](#channel-restaurants-user-actions-edit-a-restaurant)
    * [user actions - delete a restaurant](#channel-restaurants-user-actions-delete-a-restaurant)
  * [(REST) Register account](#rest-register-account)
    * [rest-register-account-create](#rest-register-account-create)
  * [(REST) Login account](#rest-login-account)
    * [rest-login-account-create](#rest-login-account-create)

# channel restaurants
## <a id=channel-restaurants-guest-actions-ping></a>guest actions - ping
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
## <a id=channel-restaurants-guest-actions-get-all-restaurants></a>guest actions - get all restaurants
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
        "address": "trollvägen 309",
        "created": "2020-07-11T00:05:37",
        "id": 7501,
        "name": "restaurant 373",
        "url": "https://341.io"
      },
      {
        "address": "trollvägen 149",
        "created": "2020-07-11T00:05:37",
        "id": 7502,
        "name": "restaurant 213",
        "url": "https://181.io"
      },
      {
        "address": "trollvägen 053",
        "created": "2020-07-11T00:05:37",
        "id": 7503,
        "name": "restaurant 117",
        "url": "https://085.io"
      }
    ]
  }
}
```
---
## <a id=channel-restaurants-guest-actions-get-one-restaurant></a>guest actions - get one restaurant
#### → <ins>Message to server</ins>
* __Topic:__ restaurants:lobby
* __Event:__ get
* __Body:__
```json
{
  "id": 7496
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "address": "trollvägen 822",
    "created": "2020-07-11T00:05:37",
    "id": 7496,
    "name": "restaurant 886",
    "url": "https://854.io"
  }
}
```
---
## <a id=channel-restaurants-user-actions-ensure-logged-in-correctly></a>user actions - ensure logged in correctly
#### → <ins>Message to server</ins>
* __Topic:__ restaurants:lobby
* __Event:__ logged_in
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "user_id": 22503
}
```
---
## <a id=channel-restaurants-user-actions-create-a-restaurant></a>user actions - create a restaurant
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
    "created": "2020-07-11T00:05:37",
    "id": 7509,
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
    "created": "2020-07-11T00:05:37",
    "id": 7509,
    "name": "test",
    "url": "some url"
  }
}
```
---
## <a id=channel-restaurants-user-actions-edit-a-restaurant></a>user actions - edit a restaurant
#### → <ins>Message to server</ins>
* __Topic:__ restaurants:lobby
* __Event:__ update
* __Body:__
```json
{
  "id": 7507,
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
    "address": "trollvägen 733",
    "created": "2020-07-11T00:05:37",
    "id": 7507,
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
    "address": "trollvägen 733",
    "created": "2020-07-11T00:05:37",
    "id": 7507,
    "name": "new name",
    "url": "new url"
  }
}
```
---
## <a id=channel-restaurants-user-actions-delete-a-restaurant></a>user actions - delete a restaurant
#### → <ins>Message to server</ins>
* __Topic:__ restaurants:lobby
* __Event:__ delete
* __Body:__
```json
{
  "id": 7505
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted restaurant 'restaurant 310' with id 7505"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ restaurants:lobby
* __Event:__ restaurant_deleted
* __Body:__
```json
{
  "id": 7505,
  "message": "Deleted restaurant 'restaurant 310'"
}
```
---
# (REST) Register account
## <a id=rest-register-account-create></a>rest-register-account-create
#### POST /register - REGISTER SUCCESS
##### Request
* __Method:__ POST
* __Path:__ /api/register
* __Request headers:__
```
content-type: multipart/mixed; boundary=plug_conn_test
```
* __Request body:__
```json
{
  "email": "user-576460752303423131@example.com",
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
x-request-id: FiCJ8P0AzMAlgE8AAAGF
```
* __Response body:__
```json
{
  "success": {
    "email": "user-576460752303423131@example.com",
    "token": "sSC9b65WzzkezvnMvS3jILvXsUdK65JmUVChnNXGsRg="
  }
}
```

#### POST /register - REGISTER FAIL
##### Request
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
x-request-id: FiCJ8P7pFMD8lmMAAAHF
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
# (REST) Login account
## <a id=rest-login-account-create></a>rest-login-account-create
#### POST /login - LOGIN SUCCESS
##### Request
* __Method:__ POST
* __Path:__ /api/login
* __Request headers:__
```
content-type: multipart/mixed; boundary=plug_conn_test
```
* __Request body:__
```json
{
  "email": "user-576460752303422270@example.com",
  "password": "hello world!"
}
```

##### ← <ins>Response to you</ins>
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FiCJ8P0AzMBuoLcAAAGl
```
* __Response body:__
```json
{
  "success": {
    "token": "d3+4T5uhrOiHIHAkCgzogvBIQT+oPr+kZFZRRxStcZE="
  }
}
```

#### POST /login - LOGIN FAIL
##### Request
* __Method:__ POST
* __Path:__ /api/login
* __Request headers:__
```
content-type: multipart/mixed; boundary=plug_conn_test
```
* __Request body:__
```json
{
  "email": "user-576460752303422812@example.com",
  "password": "lol"
}
```

##### ← <ins>Response to you</ins>
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FiCJ8P7pFMDpE5oAAAHl
```
* __Response body:__
```json
{
  "error": "Fel användarnamn eller lösenord"
}
```

---
