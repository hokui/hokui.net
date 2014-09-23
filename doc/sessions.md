## DELETE /api/session
Destroys existing access token.

### Example

#### Request
```
DELETE /api/session HTTP/1.1
Accept: application/json
Access-Token: 105536cae19da8480e23b670f28d39df74da45615bb6c439af3bfef2bc66a605
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
X-Request-Id: c930f09c-5a70-435b-8292-18237dfcb27f
X-Runtime: 0.001721
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
X-Request-Id: 57426534-297e-4569-adff-29915ded8cc4
X-Runtime: 0.113762
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
ETag: "7d57ef1c93e7b9813548f0bb3076f00b"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: b7694c43-f902-43d1-a8b4-0f83ff20189a
X-Runtime: 0.117397
X-XSS-Protection: 1; mode=block

{
  "logged_in": true,
  "token": "5217c1edb096ace6ea35c15176cfecce0aadfbaff2fb1ab47f141e3c7ab8fa76",
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
