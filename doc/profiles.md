## GET /api/profile
Returns self profile to an user.

### Example

#### Request
```
GET /api/profile HTTP/1.1
Accept: application/json
Access-Token: 937f113f8dc5de9da81c97f5867329783fc0e8fe55f62d084735c6c26b03a15e
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
ETag: W/"19ef18776a04570112fbe2cc9631f6e1"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: a52a3ec9-3f5e-456a-99d8-0e273aeb467a
X-Runtime: 0.004618
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
  "created_at": "2014-12-13T21:52:57.814+09:00",
  "updated_at": "2014-12-13T21:52:57.820+09:00",
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
Access-Token: fbd64c354ef41bd2200db97be9744084fd1860176c3feedba7b4d3cd29247aae
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
ETag: W/"f13956afc040ce80267e5b6d22f5467d"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 21283ac5-1c14-46d9-a819-6fb812ea7976
X-Runtime: 0.006430
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
  "created_at": "2014-12-13T21:52:57.951+09:00",
  "updated_at": "2014-12-13T21:52:57.966+09:00",
  "errors": {
  }
}
```
