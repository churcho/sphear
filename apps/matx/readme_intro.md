# Channel Authentication

Websocket URL: [wss://matx.se/socket/websocket](wss://matx.se/socket/websocket)

In this API spec, each endpoint is a channel and each channel might need authentication (token parameter), but some endpoints will have guest functionality though.

When subscribing to a endpoint, connect and subscribe to the topic "lobby" with or without a token.

#### Expected input if logging in with token
```json
{
  "token": "3X4MpLeT0k3n1337"
}
```
The endpoint will reply with either:
#### Subscribed to the lobby without a token
```json
{
  "guest_success": true,
  "user_id": null
}
```
## or 
#### Subscribed and authenticated to the lobby successfully
```json
{
  "login_success": true,
  "user_id": 1
}
```
---
