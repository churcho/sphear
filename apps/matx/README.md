# Matx

## Public

### Login
POST /api/login
* email:string
* password:string
-> {"success" => token:string}
-> {error:string}

### Register
POST /api/register
* email:string
* password:string
* password_confirmation:string
-> {"success" => token:string, email:string}
-> {"error" => "errors" => [field]:error_message:string}

## Authenticated

### Troll (just for testing auth)
GET /api/troll
[headers]
* Authenthication: Bearer [token]
-> {success:string}
-> {error:string}
