## POST /api/session
Returns new access token and user profile.

### Example

#### Request
```
POST /api/session HTTP/1.1


{"email":"guest@ec.hokudai.ac.jp","password":"guest"}
```

#### Response
```
HTTP/1.1 201
Content-Type: application/json; charset=utf-8

{
  "token": "213680a6d0053321bebb8efbe906b730e0a90fa56310256f3c3383688a305fd7",
  "user": {
    "id": 2,
    "email": "guest@ec.hokudai.ac.jp",
    "activation_state": "active",
    "approval_state": "approved",
    "last_login_at": "2014-01-01T00:00:00.000+09:00",
    "last_logout_at": null,
    "last_activity_at": null,
    "last_login_from_ip_address": "127.0.0.1",
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
}
```

## POST /api/session
Returns 401 if password is wrong.

### Example

#### Request
```
POST /api/session HTTP/1.1


{"email":"guest@ec.hokudai.ac.jp","password":"admin"}
```

#### Response
```
HTTP/1.1 401
Content-Type: text/html
```

## DELETE /api/session
Destroys existing access token.

### Example

#### Request
```
DELETE /api/session HTTP/1.1
Access-Token: 0dcdeb801d73c2fae082efdcb355dfd199a5693ba0d400af3889a4b3ace9ea6a
```

#### Response
```
HTTP/1.1 200
Content-Type: application/json
```
