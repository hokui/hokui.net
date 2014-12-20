## PATCH /api/profile/password
Updates password.

### Example

#### Request
```
PATCH /api/profile/password HTTP/1.1
Accept: application/json
Access-Token: 1f3c755ac04d6af669f1419b43c08925bac2a25a67c0f18200afdfdc7e04a66e
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
ETag: W/"b8b505aa273c2336f0f5b04cabddc86a"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 11680280-3a9e-4e4c-b56f-d58b819d025e
X-Runtime: 0.226293
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
  "created_at": "2014-12-20T12:15:01.850+09:00",
  "updated_at": "2014-12-20T12:15:02.085+09:00",
  "errors": {
  }
}
```
