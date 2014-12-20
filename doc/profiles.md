## GET /api/profile
Returns self profile to an user.

### Example

#### Request
```
GET /api/profile HTTP/1.1
Accept: application/json
Access-Token: 856d0875e4b4500c2ea032762fd11b758af81f338a61554b8dd71648e8127718
Content-Length: 0
Content-Type: application/json
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 482
Content-Type: application/json; charset=utf-8
ETag: W/"8205d8197945ee08f2c5a6119810f488"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 68595f8d-80ca-43b8-bae7-1b50cb3aee5d
X-Runtime: 0.004669
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
  "created_at": "2014-12-20T12:15:03.083+09:00",
  "updated_at": "2014-12-20T12:15:03.088+09:00",
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
Accept: application/json
Access-Token: 6327a5f1e53130153287703b3a357daa0f5fc789c0a1ee0e11e1231d600aaee3
Content-Length: 74
Content-Type: application/json
Host: www.example.com

{
  "handle_name": "hoge",
  "email_mobile": "hoge@example.com",
  "class_year_id": 2
}
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 480
Content-Type: application/json; charset=utf-8
ETag: W/"e1113f795340edd027bc9d4b8e222c1c"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 492fd8bd-f2c9-4a0c-a823-c3c15ab6809d
X-Runtime: 0.005351
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
  "handle_name": "hoge",
  "birthday": "1990-01-01",
  "email_mobile": "hoge@example.com",
  "admin": false,
  "class_year_id": 2,
  "created_at": "2014-12-20T12:15:03.216+09:00",
  "updated_at": "2014-12-20T12:15:03.230+09:00",
  "errors": {
  }
}
```
