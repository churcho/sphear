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
        "address": "trollvägen 206",
        "created": "2020-07-10T05:14:10",
        "id": 6549,
        "name": "restaurant 270",
        "url": "https://238.io"
      },
      {
        "address": "trollvägen 639",
        "created": "2020-07-10T05:14:10",
        "id": 6550,
        "name": "restaurant 703",
        "url": "https://671.io"
      },
      {
        "address": "trollvägen 110",
        "created": "2020-07-10T05:14:10",
        "id": 6551,
        "name": "restaurant 174",
        "url": "https://142.io"
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
  "id": 6565
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "address": "trollvägen 851",
    "created": "2020-07-10T05:14:11",
    "id": 6565,
    "name": "restaurant 915",
    "url": "https://883.io"
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
  "user_id": 21018
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
    "created": "2020-07-10T05:14:10",
    "id": 6545,
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
    "created": "2020-07-10T05:14:10",
    "id": 6545,
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
  "id": 6560,
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
    "address": "trollvägen 095",
    "created": "2020-07-10T05:14:11",
    "id": 6560,
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
    "address": "trollvägen 095",
    "created": "2020-07-10T05:14:11",
    "id": 6560,
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
  "id": 6562
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted restaurant 'restaurant 365' with id 6562"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ restaurants:lobby
* __Event:__ restaurant_deleted
* __Body:__
```json
{
  "id": 6562,
  "message": "Deleted restaurant 'restaurant 365'"
}
```
---
