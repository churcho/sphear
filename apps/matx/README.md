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


  * [channel merchandise:lobby](#channel-merchandise-lobby)
    * [test actions - ping](#channel-merchandise-lobby-test-actions-ping)
    * [test actions - ensure logged in correctly](#channel-merchandise-lobby-test-actions-ensure-logged-in-correctly)
    * [test actions - get products from menu](#channel-merchandise-lobby-test-actions-get-products-from-menu)
    * [user actions - create a product](#channel-merchandise-lobby-user-actions-create-a-product)
    * [user actions - update a product](#channel-merchandise-lobby-user-actions-update-a-product)
    * [user actions - delete a product](#channel-merchandise-lobby-user-actions-delete-a-product)
    * [user actions - change sequence of product](#channel-merchandise-lobby-user-actions-change-sequence-of-product)
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
  "user_id": 40478
}
```
---
## <a id=channel-merchandise-lobby-test-actions-get-products-from-menu></a>test actions - get products from menu
#### → <ins>Message to server</ins>
* __Topic:__ merchandise:lobby
* __Event:__ get_products
* __Body:__
```json
{
  "menu_id": 5392
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
        "id": 990,
        "menu_id": 5392,
        "name": "test product 1",
        "price": {
          "amount": 9990,
          "currency": "SEK"
        },
        "price_to_string": "99,90:-"
      },
      {
        "id": 991,
        "menu_id": 5392,
        "name": "test product 2",
        "price": {
          "amount": 4990,
          "currency": "SEK"
        },
        "price_to_string": "49,90:-"
      },
      {
        "id": 992,
        "menu_id": 5392,
        "name": "test product 3",
        "price": {
          "amount": 19900,
          "currency": "SEK"
        },
        "price_to_string": "199:-"
      },
      {
        "id": 993,
        "menu_id": 5392,
        "name": "test product 4",
        "price": {
          "amount": 99990,
          "currency": "SEK"
        },
        "price_to_string": "999,90:-"
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
  "menu_id": 5405,
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
    "id": 999,
    "menu_id": 5405,
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
    "id": 999,
    "menu_id": 5405,
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
  "product_id": 988
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "id": 988,
    "menu_id": 5388,
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
    "id": 988,
    "menu_id": 5388,
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
  "product_id": 1000
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted product 'product 509' with id 1000"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ merchandise:lobby
* __Event:__ product_deleted
* __Body:__
```json
{
  "message": "Deleted product 'product 509'",
  "product_id": 1000
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
  "menu_id": 5397
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
        "id": 994,
        "menu_id": 5397,
        "name": "test product 1",
        "price": {
          "amount": 9990,
          "currency": "SEK"
        },
        "price_to_string": "99,90:-"
      },
      {
        "id": 995,
        "menu_id": 5397,
        "name": "test product 2",
        "price": {
          "amount": 4990,
          "currency": "SEK"
        },
        "price_to_string": "49,90:-"
      },
      {
        "id": 996,
        "menu_id": 5397,
        "name": "test product 3",
        "price": {
          "amount": 19900,
          "currency": "SEK"
        },
        "price_to_string": "199:-"
      },
      {
        "id": 997,
        "menu_id": 5397,
        "name": "test product 4",
        "price": {
          "amount": 99990,
          "currency": "SEK"
        },
        "price_to_string": "999,90:-"
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
  "menu_id": 5397,
  "product_id": 997
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
        "id": 994,
        "menu_id": 5397,
        "name": "test product 1",
        "price": {
          "amount": 9990,
          "currency": "SEK"
        },
        "price_to_string": "99,90:-"
      },
      {
        "id": 997,
        "menu_id": 5397,
        "name": "test product 4",
        "price": {
          "amount": 99990,
          "currency": "SEK"
        },
        "price_to_string": "999,90:-"
      },
      {
        "id": 995,
        "menu_id": 5397,
        "name": "test product 2",
        "price": {
          "amount": 4990,
          "currency": "SEK"
        },
        "price_to_string": "49,90:-"
      },
      {
        "id": 996,
        "menu_id": 5397,
        "name": "test product 3",
        "price": {
          "amount": 19900,
          "currency": "SEK"
        },
        "price_to_string": "199:-"
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
  "menu_id": 5397,
  "product_id": 996
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
        "id": 994,
        "menu_id": 5397,
        "name": "test product 1",
        "price": {
          "amount": 9990,
          "currency": "SEK"
        },
        "price_to_string": "99,90:-"
      },
      {
        "id": 997,
        "menu_id": 5397,
        "name": "test product 4",
        "price": {
          "amount": 99990,
          "currency": "SEK"
        },
        "price_to_string": "999,90:-"
      },
      {
        "id": 996,
        "menu_id": 5397,
        "name": "test product 3",
        "price": {
          "amount": 19900,
          "currency": "SEK"
        },
        "price_to_string": "199:-"
      },
      {
        "id": 995,
        "menu_id": 5397,
        "name": "test product 2",
        "price": {
          "amount": 4990,
          "currency": "SEK"
        },
        "price_to_string": "49,90:-"
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
  "menu_id": 5397,
  "product_id": 994
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
        "id": 997,
        "menu_id": 5397,
        "name": "test product 4",
        "price": {
          "amount": 99990,
          "currency": "SEK"
        },
        "price_to_string": "999,90:-"
      },
      {
        "id": 994,
        "menu_id": 5397,
        "name": "test product 1",
        "price": {
          "amount": 9990,
          "currency": "SEK"
        },
        "price_to_string": "99,90:-"
      },
      {
        "id": 996,
        "menu_id": 5397,
        "name": "test product 3",
        "price": {
          "amount": 19900,
          "currency": "SEK"
        },
        "price_to_string": "199:-"
      },
      {
        "id": 995,
        "menu_id": 5397,
        "name": "test product 2",
        "price": {
          "amount": 4990,
          "currency": "SEK"
        },
        "price_to_string": "49,90:-"
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
  "menu_id": 5397,
  "product_id": 996
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
        "id": 996,
        "menu_id": 5397,
        "name": "test product 3",
        "price": {
          "amount": 19900,
          "currency": "SEK"
        },
        "price_to_string": "199:-"
      },
      {
        "id": 997,
        "menu_id": 5397,
        "name": "test product 4",
        "price": {
          "amount": 99990,
          "currency": "SEK"
        },
        "price_to_string": "999,90:-"
      },
      {
        "id": 994,
        "menu_id": 5397,
        "name": "test product 1",
        "price": {
          "amount": 9990,
          "currency": "SEK"
        },
        "price_to_string": "99,90:-"
      },
      {
        "id": 995,
        "menu_id": 5397,
        "name": "test product 2",
        "price": {
          "amount": 4990,
          "currency": "SEK"
        },
        "price_to_string": "49,90:-"
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
  "menu_id": 5397,
  "product_id": 997
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
        "id": 996,
        "menu_id": 5397,
        "name": "test product 3",
        "price": {
          "amount": 19900,
          "currency": "SEK"
        },
        "price_to_string": "199:-"
      },
      {
        "id": 994,
        "menu_id": 5397,
        "name": "test product 1",
        "price": {
          "amount": 9990,
          "currency": "SEK"
        },
        "price_to_string": "99,90:-"
      },
      {
        "id": 995,
        "menu_id": 5397,
        "name": "test product 2",
        "price": {
          "amount": 4990,
          "currency": "SEK"
        },
        "price_to_string": "49,90:-"
      },
      {
        "id": 997,
        "menu_id": 5397,
        "name": "test product 4",
        "price": {
          "amount": 99990,
          "currency": "SEK"
        },
        "price_to_string": "999,90:-"
      }
    ]
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
  "user_id": 40470
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
        "address": "trollvägen 638",
        "created": "2020-07-22T18:27:03",
        "id": 26161,
        "menus": [],
        "name": "restaurant 702",
        "url": "https://670.io"
      },
      {
        "address": "trollvägen 478",
        "created": "2020-07-22T18:27:03",
        "id": 26162,
        "menus": [],
        "name": "restaurant 542",
        "url": "https://510.io"
      },
      {
        "address": "trollvägen 382",
        "created": "2020-07-22T18:27:03",
        "id": 26163,
        "menus": [],
        "name": "restaurant 446",
        "url": "https://414.io"
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
  "restaurant_id": 26134
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "address": "trollvägen 523",
    "created": "2020-07-22T18:27:02",
    "id": 26134,
    "menus": [
      {
        "id": 5369,
        "name": "menu 395",
        "products": [],
        "restaurant_id": 26134
      }
    ],
    "name": "restaurant 587",
    "url": "https://555.io"
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
  "restaurant_id": 26176
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
        "id": 5379,
        "name": "test menu1",
        "products": [],
        "restaurant_id": 26176
      },
      {
        "id": 5380,
        "name": "test menu2",
        "products": [],
        "restaurant_id": 26176
      },
      {
        "id": 5381,
        "name": "test menu3",
        "products": [],
        "restaurant_id": 26176
      },
      {
        "id": 5382,
        "name": "test menu4",
        "products": [],
        "restaurant_id": 26176
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
  "menu_id": 5378
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "id": 5378,
    "name": "test menu1",
    "products": [],
    "restaurant_id": 26170
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
    "created": "2020-07-22T18:27:03",
    "id": 26147,
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
    "created": "2020-07-22T18:27:03",
    "id": 26147,
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
  "restaurant_id": 26157
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "address": "trollvägen 830",
    "created": "2020-07-22T18:27:03",
    "id": 26157,
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
    "address": "trollvägen 830",
    "created": "2020-07-22T18:27:03",
    "id": 26157,
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
  "restaurant_id": 26165
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted restaurant 'restaurant 263' with id 26165"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ restaurants:lobby
* __Event:__ restaurant_deleted
* __Body:__
```json
{
  "message": "Deleted restaurant 'restaurant 263'",
  "restaurant_id": 26165
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
  "restaurant_id": 26153
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "id": 5376,
    "name": "test menu",
    "products": [],
    "restaurant_id": 26153
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
    "id": 5376,
    "name": "test menu",
    "products": [],
    "restaurant_id": 26153
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
  "menu_id": 5375,
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
    "id": 5375,
    "name": "some new name",
    "products": [],
    "restaurant_id": 26151
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
    "id": 5375,
    "name": "some new name",
    "products": [],
    "restaurant_id": 26151
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
  "menu_id": 5383
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "message": "Deleted menu 'test menu1' with id 5383"
}
```
#### ← <ins>Broadcasted to all</ins>
* __Topic:__ restaurants:lobby
* __Event:__ menu_deleted
* __Body:__
```json
{
  "menu_id": 5383,
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
  "restaurant_id": 26189
}
```
#### ← <ins>Reply to you</ins>
* __Status:__ ok
* __Body:__
```json
{
  "data": {
    "address": "trollvägen 294",
    "created": "2020-07-22T18:27:03",
    "id": 26189,
    "menus": [
      {
        "id": 5384,
        "name": "test menu1",
        "products": [],
        "restaurant_id": 26189
      },
      {
        "id": 5385,
        "name": "test menu2",
        "products": [],
        "restaurant_id": 26189
      },
      {
        "id": 5386,
        "name": "test menu3",
        "products": [],
        "restaurant_id": 26189
      },
      {
        "id": 5387,
        "name": "test menu4",
        "products": [],
        "restaurant_id": 26189
      }
    ],
    "name": "restaurant 358",
    "url": "https://326.io"
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
  "menu_id": 5387,
  "restaurant_id": 26189
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
        "id": 5384,
        "name": "test menu1",
        "products": [],
        "restaurant_id": 26189
      },
      {
        "id": 5387,
        "name": "test menu4",
        "products": [],
        "restaurant_id": 26189
      },
      {
        "id": 5385,
        "name": "test menu2",
        "products": [],
        "restaurant_id": 26189
      },
      {
        "id": 5386,
        "name": "test menu3",
        "products": [],
        "restaurant_id": 26189
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
  "menu_id": 5386,
  "restaurant_id": 26189
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
        "id": 5384,
        "name": "test menu1",
        "products": [],
        "restaurant_id": 26189
      },
      {
        "id": 5387,
        "name": "test menu4",
        "products": [],
        "restaurant_id": 26189
      },
      {
        "id": 5386,
        "name": "test menu3",
        "products": [],
        "restaurant_id": 26189
      },
      {
        "id": 5385,
        "name": "test menu2",
        "products": [],
        "restaurant_id": 26189
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
  "menu_id": 5384,
  "restaurant_id": 26189
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
        "id": 5387,
        "name": "test menu4",
        "products": [],
        "restaurant_id": 26189
      },
      {
        "id": 5384,
        "name": "test menu1",
        "products": [],
        "restaurant_id": 26189
      },
      {
        "id": 5386,
        "name": "test menu3",
        "products": [],
        "restaurant_id": 26189
      },
      {
        "id": 5385,
        "name": "test menu2",
        "products": [],
        "restaurant_id": 26189
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
  "menu_id": 5386,
  "restaurant_id": 26189
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
        "id": 5386,
        "name": "test menu3",
        "products": [],
        "restaurant_id": 26189
      },
      {
        "id": 5387,
        "name": "test menu4",
        "products": [],
        "restaurant_id": 26189
      },
      {
        "id": 5384,
        "name": "test menu1",
        "products": [],
        "restaurant_id": 26189
      },
      {
        "id": 5385,
        "name": "test menu2",
        "products": [],
        "restaurant_id": 26189
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
  "menu_id": 5387,
  "restaurant_id": 26189
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
        "id": 5386,
        "name": "test menu3",
        "products": [],
        "restaurant_id": 26189
      },
      {
        "id": 5384,
        "name": "test menu1",
        "products": [],
        "restaurant_id": 26189
      },
      {
        "id": 5385,
        "name": "test menu2",
        "products": [],
        "restaurant_id": 26189
      },
      {
        "id": 5387,
        "name": "test menu4",
        "products": [],
        "restaurant_id": 26189
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
  "email": "user-576460752303422173@example.com",
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
x-request-id: FiQmbfr6WgA3NIAAAAVD
```
* __Response body:__
```json
{
  "success": {
    "email": "user-576460752303422173@example.com",
    "token": "eXCWw0DmkNcXZL0Ib3kKuJuFaBZ5R4jIIvHSY2JPfs0="
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
x-request-id: FiQmbf24QYA53v4AAAvB
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
  "email": "user-576460752303421020@example.com",
  "password": "hello world!"
}
```

##### ← <ins>Response to you</ins>
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FiQmbfr6WgCO-SMAAAVj
```
* __Response body:__
```json
{
  "success": {
    "token": "Ap0H5jrZCJaKtyB8xDKJ9UmnbodE77fYi4zMlsGbZPU="
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
  "email": "user-576460752303422682@example.com",
  "password": "lol"
}
```

##### ← <ins>Response to you</ins>
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FiQmbf24QYBUYDEAAANG
```
* __Response body:__
```json
{
  "error": "Fel användarnamn eller lösenord"
}
```

---
