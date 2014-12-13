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
Content-Length: 600
Content-Type: application/json; charset=utf-8
ETag: W/"71bb7d35fb9ed5a709d178fb515846c8"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 1c8bcf81-9ef9-4f9e-aa9a-8cd2189f3371
X-Runtime: 0.118209
X-XSS-Protection: 1; mode=block

{
  "token": "231fb2309244936d8c75f4f38ed325f2a9d05d4f156c0418199524527b424498",
  "user": {
    "id": 2,
    "email": "guest@ec.hokudai.ac.jp",
    "activation_state": "active",
    "approval_state": "approved",
    "last_login_at": "2014-12-13T21:52:57.275+09:00",
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
    "created_at": "2014-12-13T21:52:57.150+09:00",
    "updated_at": "2014-12-13T21:52:57.157+09:00",
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
Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
Content-Length: 53
Content-Type: application/x-www-form-urlencoded
Host: www.example.com

{"email":"guest@ec.hokudai.ac.jp","password":"admin"}
```

#### Response
```
HTTP/1.1 401
Cache-Control: no-cache
Content-Length: 1
Content-Type: text/html
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 27cf95b8-c665-468e-9915-c10934f474bc
X-Runtime: 0.108945
X-XSS-Protection: 1; mode=block
```

## DELETE /api/session
Destroys existing access token.

### Example

#### Request
```
DELETE /api/session HTTP/1.1
Accept: application/json
Access-Token: 1f77128379281e02c57403699eac0bf5ad47ef162ee78888e8df21419a04cac5
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
ETag: W/"7215ee9c7d9dc229d2921a40e899ec5f"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 25228a3e-fab1-4a82-9c0d-98aa732881f9
X-Runtime: 0.003545
X-XSS-Protection: 1; mode=block
```
