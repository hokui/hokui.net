## GET /api/profile
Returns self profile to an user.

### Example

#### Request
```
GET /api/profile HTTP/1.1
Access-Token: b216d69ad67cbf7be9769d3eaa9a1bb5cee8ad09b2592bae46dcb24af492e02e
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

## PATCH /api/profile
Updates profile.

### Example

#### Request
```
PATCH /api/profile HTTP/1.1
Access-Token: 0bbbeb1874ea83dd455699b864156730dd1afbec09ce93db78d46eef86ea34a4

{
  "handle_name": "hoge",
  "email_mobile": "hoge@example.com",
  "class_year_id": 2
}
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
  "handle_name": "hoge",
  "birthday": "1990-01-01",
  "email_mobile": "hoge@example.com",
  "admin": false,
  "class_year_id": 2,
  "created_at": "2014-01-01T00:00:00.000+09:00",
  "updated_at": "2014-01-01T00:00:00.000+09:00",
  "errors": {
  }
}
```
