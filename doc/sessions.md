## DELETE /api/session
Destroys existing access token.

### Example

#### Request
```
DELETE /api/session HTTP/1.1
Accept: application/json
Access-Token: 498dc4e7a2711be58beab8611f91bc76877da610f8b82fda3ec17ba5b51ace7b
Content-Length: 0
Content-Type: application/json
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 19
Content-Type: application/json; charset=utf-8
ETag: "375ee5cd444bb99803430a565181a517"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: b7b4b0e7-bc5e-44d2-9e11-a704b6fcfb6a
X-Runtime: 0.001712
X-XSS-Protection: 1; mode=block

{
  "logged_out": true
}
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
Content-Length: 19
Content-Type: application/json; charset=utf-8
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 0e7fd1f4-fac1-42b6-aaa8-3325b770091d
X-Runtime: 0.109133
X-XSS-Protection: 1; mode=block

{
  "logged_in": false
}
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
Content-Length: 293
Content-Type: application/json; charset=utf-8
ETag: "b6a7c36b6c5c57122316a4bd3ee2f7fd"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 5a0e692f-5e3b-45fe-aa99-e4209eea44a0
X-Runtime: 0.112720
X-XSS-Protection: 1; mode=block

{
  "logged_in": true,
  "token": "3bfe3c4240018b4c6ae9e7790efcb00403eea2d8a85cf0e824e9fda98225aece",
  "user": {
    "id": 1,
    "email": "guest@ec.hokudai.ac.jp",
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
