## PATCH /api/profile/password
Updates password.

### Example

#### Request
```
PATCH /api/profile/password HTTP/1.1
Accept: application/json
Access-Token: 51d8c07e9a9316b222bcb819d9f3f089b594bcda59e348d7e3044ffd7a608285
Content-Length: 50
Content-Type: application/json
Host: www.example.com

{
  "current_password": "guest",
  "password": "hogefuga"
}
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 482
Content-Type: application/json; charset=utf-8
ETag: W/"c16ab617bb4362759bc25d325c13d24d"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 68ed73c5-f93d-44e2-85f7-7fff60eb3054
X-Runtime: 0.222281
X-XSS-Protection: 1; mode=block

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
  "created_at": "2014-12-13T21:53:03.808+09:00",
  "updated_at": "2014-12-13T21:53:04.039+09:00",
  "errors": {
  }
}
```
