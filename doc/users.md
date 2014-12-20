## GET /api/users
Returns a list of users to an admin.

### Example

#### Request
```
GET /api/users HTTP/1.1
Access-Token: 29f61ad0c50ddd461d34b861d794e0fa3ce4b100e2be396de046d5665b6509cb
```

#### Response
```
HTTP/1.1 200
Content-Type: application/json; charset=utf-8

[
  {
    "id": 1,
    "email": "admin@ec.hokudai.ac.jp",
    "activation_state": "active",
    "approval_state": "approved",
    "last_login_at": null,
    "last_logout_at": null,
    "last_activity_at": null,
    "last_login_from_ip_address": null,
    "family_name": "admin",
    "given_name": "admin",
    "full_name": "admin admin",
    "handle_name": "admin",
    "birthday": "1990-01-01",
    "email_mobile": "admin@example.com",
    "admin": true,
    "class_year_id": 1,
    "created_at": "2014-01-01T00:00:00.000+09:00",
    "updated_at": "2014-01-01T00:00:00.000+09:00",
    "errors": {
    }
  }
]
```

## GET /api/users
Returns 403 to a guest.

### Example

#### Request
```
GET /api/users HTTP/1.1
Access-Token: 5be9484cf7aa35007f908237e43651d6b79d347c05949b0b1f7ad3da9908cf52
```

#### Response
```
HTTP/1.1 403
Content-Type: application/json
```

## GET /api/users/1
Returns user profile to an admin.

### Example

#### Request
```
GET /api/users/2 HTTP/1.1
Access-Token: 3e67aba0b83ac1781853006446c1cda99aa1c80bb07f06b2ef786e78a3f4ea4e
```

#### Response
```
HTTP/1.1 200
Content-Type: application/json; charset=utf-8

{
  "id": 2,
  "email": "guest@ec.hokudai.ac.jp",
  "activation_state": "active",
  "approval_state": "approved",
  "last_login_at": null,
  "last_logout_at": null,
  "last_activity_at": null,
  "last_login_from_ip_address": null,
  "family_name": "guest",
  "given_name": "guest",
  "full_name": "guest guest",
  "handle_name": "guest",
  "birthday": "1990-01-01",
  "email_mobile": "guest@example.com",
  "admin": false,
  "class_year_id": 1,
  "created_at": "2014-01-01T00:00:00.000+09:00",
  "updated_at": "2014-01-01T00:00:00.000+09:00",
  "errors": {
  }
}
```

## GET /api/users/1
Returns user profile to a guest if the client requests profile of oneself.

### Example

#### Request
```
GET /api/users/2 HTTP/1.1
Access-Token: c77495d838c6452098a2e220ab78986ff352fca904c5bab16ccf7abd9b8a5bf4
```

#### Response
```
HTTP/1.1 200
Content-Type: application/json; charset=utf-8

{
  "id": 2,
  "email": "guest@ec.hokudai.ac.jp",
  "activation_state": "active",
  "approval_state": "approved",
  "last_login_at": null,
  "last_logout_at": null,
  "last_activity_at": null,
  "last_login_from_ip_address": null,
  "family_name": "guest",
  "given_name": "guest",
  "full_name": "guest guest",
  "handle_name": "guest",
  "birthday": "1990-01-01",
  "email_mobile": "guest@example.com",
  "admin": false,
  "class_year_id": 1,
  "created_at": "2014-01-01T00:00:00.000+09:00",
  "updated_at": "2014-01-01T00:00:00.000+09:00",
  "errors": {
  }
}
```

## GET /api/users/1
Returns 403 to a guest if the client requests profile of another user.

### Example

#### Request
```
GET /api/users/1 HTTP/1.1
Access-Token: b423dfa0cf927fc8576edfce0dee5957983ae74806bd3ce6cc48120b283af5ef
```

#### Response
```
HTTP/1.1 403
Content-Type: application/json
```

## POST /api/users
Creates new user.

### Example

#### Request
```
POST /api/users HTTP/1.1


{"id":2,"email":"guest@ec.hokudai.ac.jp","password":"guest","family_name":"guest","given_name":"guest","handle_name":"guest","birthday":"1990-01-01","email_mobile":"guest@example.com","class_year_id":1}
```

#### Response
```
HTTP/1.1 201
Content-Type: application/json; charset=utf-8

{
  "id": 3,
  "email": "guest@ec.hokudai.ac.jp",
  "activation_state": "pending",
  "approval_state": "waiting",
  "last_login_at": null,
  "last_logout_at": null,
  "last_activity_at": null,
  "last_login_from_ip_address": null,
  "family_name": "guest",
  "given_name": "guest",
  "full_name": "guest guest",
  "handle_name": "guest",
  "birthday": "1990-01-01",
  "email_mobile": "guest@example.com",
  "admin": false,
  "class_year_id": 1,
  "created_at": "2014-01-01T00:00:00.000+09:00",
  "updated_at": "2014-01-01T00:00:00.000+09:00",
  "errors": {
  }
}
```

## POST /api/users/activate
Successes if the guest is previously unactivated.

### Example

#### Request
```
POST /api/users/activate HTTP/1.1


{"activation_token":"Vsm84stwioKYcTzsTHjF"}
```

#### Response
```
HTTP/1.1 200
Content-Type: text/html
```

## POST /api/users/activate
Fails if the guest is already activated.

### Example

#### Request
```
POST /api/users/activate HTTP/1.1


{"activation_token":"rJxV6jWwnP9UsY4uPGNy"}
```

#### Response
```
HTTP/1.1 400
Content-Type: text/html
```

## POST /api/users/1/approve
Successes when an admin approves a guest.

### Example

#### Request
```
POST /api/users/2/approve HTTP/1.1
Access-Token: 35946276ff90be671a1d16e5d624a77be78b1dedb7c83eeb341961cca3680fc5
```

#### Response
```
HTTP/1.1 200
Content-Type: application/json
```

## POST /api/users/1/approve
Returns 403 to a guest.

### Example

#### Request
```
POST /api/users/2/approve HTTP/1.1
Access-Token: 6f7f506679423c2d98e406074b84e1bfc2dd0e6b0c31b7b2636f55d081a1d583
```

#### Response
```
HTTP/1.1 403
Content-Type: application/json
```

## DELETE /api/users/1
Successes.

### Example

#### Request
```
DELETE /api/users/2 HTTP/1.1
Access-Token: 7b7ac5ca50fcc304af6a0f49c26b4f48c445dda409e7bea4b5cf401265bcd075
```

#### Response
```
HTTP/1.1 200
Content-Type: application/json
```

## DELETE /api/users/1
Returns 403 to a guest.

### Example

#### Request
```
DELETE /api/users/1 HTTP/1.1
Access-Token: d92f362fec72038a053871afc1da0b2f32baca46af4c88e7e40236678abcefe9
```

#### Response
```
HTTP/1.1 403
Content-Type: application/json
```
