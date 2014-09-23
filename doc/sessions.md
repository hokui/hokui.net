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
ETag: "ee90bd3154a28265eb42751d24cdedb9"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 21fc0cfa-bd44-4678-88e6-5d14885dce77
X-Runtime: 0.211345
X-XSS-Protection: 1; mode=block

{
  "logged_in": true,
  "token": "6fd8316e5a940d669896a76b448ad894d40783d90c961833cb31697aefda5b31",
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
X-Request-Id: 87b07320-3268-4142-bbba-7ac3aa198241
X-Runtime: 0.191720
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
Access-Token: 3f4bb04c57106258959f47acf3dc91f6b768033035518e37e6daa7b2964e466f
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
X-Request-Id: 49f82993-a988-406a-83d5-606c4fec5df8
X-Runtime: 0.003037
X-XSS-Protection: 1; mode=block

{
  "logged_out": true
}
```
