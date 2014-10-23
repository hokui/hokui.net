## DELETE /api/session
Destroys existing access token.

### Example

#### Request
```
DELETE /api/session HTTP/1.1
Accept: application/json
Access-Token: f18158cb20828da62a4e5ce410e1e0cf83720c19650ab58298668a4e49f7623a
Content-Length: 0
Content-Type: application/json
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 1
Content-Type: application/json
ETag: "7215ee9c7d9dc229d2921a40e899ec5f"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: b6379787-ccd8-41ca-8362-a1cd7463f78b
X-Runtime: 0.001626
X-XSS-Protection: 1; mode=block
```

## POST /api/session
Returns 422 if password is wrong.

### Example

#### Request
```
POST /api/session HTTP/1.1
Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
Content-Length: 53
Content-Type: application/x-www-form-urlencoded
Host: www.example.com

{"email":"guest@ec.hokudai.ac.jp","password":"admin"}
```

#### Response
```
HTTP/1.1 422
Cache-Control: no-cache
Content-Length: 1
Content-Type: text/html
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: a41fbc5d-6d0a-405c-9180-e185fa4dbe80
X-Runtime: 0.134519
X-XSS-Protection: 1; mode=block
```

## POST /api/session
Returns new access token and user profile.

### Example

#### Request
```
POST /api/session HTTP/1.1
Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
Content-Length: 53
Content-Type: application/x-www-form-urlencoded
Host: www.example.com

{"email":"guest@ec.hokudai.ac.jp","password":"guest"}
```

#### Response
```
HTTP/1.1 201
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 476
Content-Type: application/json; charset=utf-8
ETag: "42965bfac1bc294d81f5026587fe9339"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: df8763fe-b1a9-4242-9e00-9d1bdfdbbf4d
X-Runtime: 0.138692
X-XSS-Protection: 1; mode=block

{
  "token": "41d74e0dd22b659b6311424658d4d951ff65ac7433c13ae3679cd3f343225d15",
  "user": {
    "id": 1,
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
    "errors": {
    }
  }
}
```
