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
ETag: "32717d5759119cdecc674c1cba668f03"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: cdced8cb-aea7-406f-b232-bcf9ba03bcfa
X-Runtime: 0.158283
X-XSS-Protection: 1; mode=block

{
  "logged_in": true,
  "token": "b1bae6ffeb78ceab84c46dc976839746bfa58c63eea0308fb19fb270c88396e2",
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
X-Request-Id: f054f256-0d1d-479e-9e71-d4174f4ffd99
X-Runtime: 0.146837
X-XSS-Protection: 1; mode=block

{
  "logged_in": false
}
```

## DELETE /api/session
Destroys existing access token.

### Example

#### Request
```
DELETE /api/session HTTP/1.1
Accept: application/json
Access-Token: 28f410a0084d0fcdcf7e4068b4cc987e7ca9cc478d760279895cd28444da4922
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
X-Request-Id: 8df4a7ee-a6a0-490f-8d27-61ed99422f67
X-Runtime: 0.004475
X-XSS-Protection: 1; mode=block

{
  "logged_out": true
}
```
