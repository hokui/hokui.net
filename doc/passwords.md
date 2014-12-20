## PATCH /api/profile/password
Updates password.

### Example

#### Request
```
PATCH /api/profile/password HTTP/1.1
Access-Token: a8dad16e75bfb068a32229efd16cc0b4823a624a66e32b3fbd1b4f3e65136e5f

{
  "current_password": "guest",
  "password": "hogefuga"
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
