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
ETag: W/"60b7b5b6f5293df71828483b5a2df572"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 547548fc-1b88-4ac1-9e9c-7e140f6cd8f2
X-Runtime: 0.119855
X-XSS-Protection: 1; mode=block

{
  "token": "83e2aabf55182e8c15913ef6e4d7db4976f3eb5b3f483355448db44f45a65e37",
  "user": {
    "id": 2,
    "email": "guest@ec.hokudai.ac.jp",
    "activation_state": "active",
    "approval_state": "approved",
    "last_login_at": "2014-12-20T12:15:05.286+09:00",
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
    "created_at": "2014-12-20T12:15:05.161+09:00",
    "updated_at": "2014-12-20T12:15:05.166+09:00",
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
X-Request-Id: 2150ce17-7d6e-49b2-a89e-b804c8aac299
X-Runtime: 0.110531
X-XSS-Protection: 1; mode=block
```

## DELETE /api/session
Destroys existing access token.

### Example

#### Request
```
DELETE /api/session HTTP/1.1
Accept: application/json
Access-Token: 4794c36c91c119e98aaf23acd2ccc2d9254cee67c7c34fa36387b9bc6f5d95fd
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
X-Request-Id: 5be76b54-86e7-4dc6-9a48-286d3cffda19
X-Runtime: 0.003313
X-XSS-Protection: 1; mode=block
```
