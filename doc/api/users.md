## GET /api/users
Returns a list of users to an admin.

### Example

#### Request
```
GET /api/users HTTP/1.1
Access-Token: 0dcdeb801d73c2fae082efdcb355dfd199a5693ba0d400af3889a4b3ace9ea6a
```

#### Response
```
HTTP/1.1 200
Content-Type: application/json; charset=utf-8

[
  {
    "id": 1,
    "email": "admin@eis.hokudai.ac.jp",
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
    "class_year_id": 8,
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
Access-Token: 0dcdeb801d73c2fae082efdcb355dfd199a5693ba0d400af3889a4b3ace9ea6a
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
Access-Token: 0dcdeb801d73c2fae082efdcb355dfd199a5693ba0d400af3889a4b3ace9ea6a
```

#### Response
```
HTTP/1.1 200
Content-Type: application/json; charset=utf-8

{
  "id": 2,
  "email": "guest@eis.hokudai.ac.jp",
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
  "class_year_id": 8,
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
Access-Token: 0dcdeb801d73c2fae082efdcb355dfd199a5693ba0d400af3889a4b3ace9ea6a
```

#### Response
```
HTTP/1.1 200
Content-Type: application/json; charset=utf-8

{
  "id": 2,
  "email": "guest@eis.hokudai.ac.jp",
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
  "class_year_id": 8,
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
Access-Token: 0dcdeb801d73c2fae082efdcb355dfd199a5693ba0d400af3889a4b3ace9ea6a
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


{"id":2,"email":"guest@eis.hokudai.ac.jp","password":"guest","family_name":"guest","given_name":"guest","handle_name":"guest","birthday":"1990-01-01","email_mobile":"guest@example.com"}
```

#### Response
```
HTTP/1.1 201
Content-Type: application/json; charset=utf-8

{
  "id": 3,
  "email": "guest@eis.hokudai.ac.jp",
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


{"activation_token":"aQq2mRshh8KzdXtqqLV5"}
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


{"activation_token":"K6PNsKfhAD7QFYPSMyvW"}
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
Access-Token: 0dcdeb801d73c2fae082efdcb355dfd199a5693ba0d400af3889a4b3ace9ea6a
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
Access-Token: 0dcdeb801d73c2fae082efdcb355dfd199a5693ba0d400af3889a4b3ace9ea6a
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
Access-Token: 0dcdeb801d73c2fae082efdcb355dfd199a5693ba0d400af3889a4b3ace9ea6a
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
Access-Token: 0dcdeb801d73c2fae082efdcb355dfd199a5693ba0d400af3889a4b3ace9ea6a
```

#### Response
```
HTTP/1.1 403
Content-Type: application/json
```
