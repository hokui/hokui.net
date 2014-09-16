## DELETE /api/session
Destroys existing access token.

### Example

#### Request
```
DELETE /api/session HTTP/1.1
Accept: application/json
Access-Token: fa13dbfd79f1e4e976766b64fb6f1a5e40161b8f3bcf17e95d63e7778c7dc14e
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
X-Request-Id: 6b959137-b05a-4c88-9567-6e34762709a7
X-Runtime: 0.002017
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
X-Request-Id: d3adfc8e-1114-40a5-ba66-f04a6a3b97fe
X-Runtime: 0.134775
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
Content-Length: 298
Content-Type: application/json; charset=utf-8
ETag: "9aa1e9155d287e692bec3d86328fdac8"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 23c59804-efbd-4716-99a6-8aa834f97348
X-Runtime: 0.141215
X-XSS-Protection: 1; mode=block

{
  "logged_in": true,
  "token": "75c8afd873db8da134718e3b90ae0aeb19a2fe51cf6793043330da2302206757",
  "user": {
    "id": 1,
    "email": "guest@ec.hokudai.ac.jp",
    "full_name": "guest guest",
    "handle_name": "guest",
    "birthday": "1990-01-01",
    "email_mobile": "guest@example.com",
    "admin": false,
    "graduation_year_id": 1,
    "errors": {
    }
  }
}
```
