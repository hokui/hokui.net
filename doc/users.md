## POST /api/users/activate
Successes if the guest is previously unactivated.

### Example

#### Request
```
POST /api/users/activate HTTP/1.1
Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
Content-Length: 43
Content-Type: application/x-www-form-urlencoded
Host: www.example.com

{"activation_token":"zdNthvnXQsk6pFtdyifp"}
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 1
Content-Type: text/html
ETag: W/"7215ee9c7d9dc229d2921a40e899ec5f"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: f9c56d6b-12e9-413b-857a-74a2b1d47ec5
X-Runtime: 0.003208
X-XSS-Protection: 1; mode=block
```

## POST /api/users/activate
Fails if the guest is already activated.

### Example

#### Request
```
POST /api/users/activate HTTP/1.1
Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
Content-Length: 43
Content-Type: application/x-www-form-urlencoded
Host: www.example.com

{"activation_token":"AXXoCfenRuNzdHqyAo1c"}
```

#### Response
```
HTTP/1.1 400
Cache-Control: no-cache
Content-Length: 1
Content-Type: text/html
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: c63406fe-950f-43d8-aeaf-31cd68d41db4
X-Runtime: 0.001397
X-XSS-Protection: 1; mode=block
```

## POST /api/users/1/approve
Successes when an admin approves a guest.

### Example

#### Request
```
POST /api/users/2/approve HTTP/1.1
Accept: application/json
Access-Token: 65889f9707ecadecada24bd78cdd41626a93d114fe63503708691bdccda6a062
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
X-Request-Id: dd88a29d-a8ca-48c4-a1ed-ac1340616ace
X-Runtime: 0.003891
X-XSS-Protection: 1; mode=block
```

## POST /api/users/1/approve
Returns 403 to a guest.

### Example

#### Request
```
POST /api/users/2/approve HTTP/1.1
Accept: application/json
Access-Token: 695547bbc853e489f7bd4bdbac38503bb76a3ca38a54fdaecf0bc0a37711baee
Content-Length: 0
Content-Type: application/json
Host: www.example.com
```

#### Response
```
HTTP/1.1 403
Cache-Control: no-cache
Content-Length: 1
Content-Type: application/json
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 020aaf85-5846-4d4f-ba8d-f49c0183c2ee
X-Runtime: 0.001891
X-XSS-Protection: 1; mode=block
```

## DELETE /api/users/1
Successes.

### Example

#### Request
```
DELETE /api/users/2 HTTP/1.1
Accept: application/json
Access-Token: f2f4ab857ccaee9f14f172aa355bed48cd7fc867e7beb3feddecad92154054ba
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
X-Request-Id: 72c01577-3545-4531-9508-ff5851a44eb5
X-Runtime: 0.003582
X-XSS-Protection: 1; mode=block
```

## DELETE /api/users/1
Returns 403 to a guest.

### Example

#### Request
```
DELETE /api/users/1 HTTP/1.1
Accept: application/json
Access-Token: 31a96c88db3959b07fb82a6dc75bddbe6a8eb88eb8f7646c847503ab5788c6b3
Content-Length: 0
Content-Type: application/json
Host: www.example.com
```

#### Response
```
HTTP/1.1 403
Cache-Control: no-cache
Content-Length: 1
Content-Type: application/json
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 4936a701-778d-4a38-be1e-7f760d3db356
X-Runtime: 0.001866
X-XSS-Protection: 1; mode=block
```

## POST /api/users
Creates new user.

### Example

#### Request
```
POST /api/users HTTP/1.1
Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
Content-Length: 202
Content-Type: application/x-www-form-urlencoded
Host: www.example.com

{"id":2,"email":"guest@ec.hokudai.ac.jp","password":"guest","family_name":"guest","given_name":"guest","handle_name":"guest","birthday":"1990-01-01","email_mobile":"guest@example.com","class_year_id":1}
```

#### Response
```
HTTP/1.1 201
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 482
Content-Type: application/json; charset=utf-8
ETag: W/"13ee2ca6f9bb87118cb56a7ad0f76ac5"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 92be0463-90fe-438f-b135-d0f2a9167d9d
X-Runtime: 0.115919
X-XSS-Protection: 1; mode=block

{
  "id": 3,
  "email": "guest@ec.hokudai.ac.jp",
  "activation_state": "pending",
  "approval_state": "waiting",
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
  "created_at": "2014-12-13T21:53:02.392+09:00",
  "updated_at": "2014-12-13T21:53:02.392+09:00",
  "errors": {
  }
}
```

## GET /api/users
Returns a list of users to an admin.

### Example

#### Request
```
GET /api/users HTTP/1.1
Accept: application/json
Access-Token: 2ec77591efb55d4a952c552bc60e8e357f44072b45d62164c945e8cdf8724c37
Content-Length: 0
Content-Type: application/json
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 483
Content-Type: application/json; charset=utf-8
ETag: W/"cc951f2e2d9b41138663b25159747c1e"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 997ed7cd-e2de-4ecb-bf0e-cb5d1f2bbbb1
X-Runtime: 0.003252
X-XSS-Protection: 1; mode=block

[
  {
    "id": 1,
    "email": "admin@ec.hokudai.ac.jp",
    "activation_state": "active",
    "approval_state": "approved",
    "last_login_at": null,
    "last_logout_at": null,
    "last_activity_at": null,
    "last_login_from_ip_address": null,
    "family_name": "admin",
    "given_name": "admin",
    "full_name": "admin admin",
    "handle_name": "admin",
    "birthday": "1990-01-01",
    "email_mobile": "admin@example.com",
    "admin": true,
    "class_year_id": 1,
    "created_at": "2014-12-13T21:53:02.524+09:00",
    "updated_at": "2014-12-13T21:53:02.529+09:00",
    "errors": {
    }
  }
]
```

## GET /api/users
Returns 403 to a guest.

### Example

#### Request
```
GET /api/users HTTP/1.1
Accept: application/json
Access-Token: a21651b4ddf2d1123c8e92704a5d35c946f95d3a623d18d8e2a64941b1b9542c
Content-Length: 0
Content-Type: application/json
Host: www.example.com
```

#### Response
```
HTTP/1.1 403
Cache-Control: no-cache
Content-Length: 1
Content-Type: application/json
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: ee336de6-1d9c-4887-afda-60a7fa226c21
X-Runtime: 0.001691
X-XSS-Protection: 1; mode=block
```

## GET /api/users/1
Returns 403 to a guest if the client requests profile of another user.

### Example

#### Request
```
GET /api/users/1 HTTP/1.1
Accept: application/json
Access-Token: e56b94680a38ada60acb33b7616ce8860ff7355834ec405b86a8389c1710b077
Content-Length: 0
Content-Type: application/json
Host: www.example.com
```

#### Response
```
HTTP/1.1 403
Cache-Control: no-cache
Content-Length: 1
Content-Type: application/json
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 6dd29111-8c16-46c5-bcfd-181efaeb8ed8
X-Runtime: 0.002017
X-XSS-Protection: 1; mode=block
```

## GET /api/users/1
Returns user profile to an admin.

### Example

#### Request
```
GET /api/users/2 HTTP/1.1
Accept: application/json
Access-Token: dd6e09612630a99fa66620ba1f592559a13b2f466dcf8ca4b261a2b9d9cb8d05
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
ETag: W/"5043e75b5a2d426948e25d34fbc7a481"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: d1ab9856-0998-4728-99ea-a7ddda8aa8cf
X-Runtime: 0.003955
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
  "created_at": "2014-12-13T21:53:03.141+09:00",
  "updated_at": "2014-12-13T21:53:03.147+09:00",
  "errors": {
  }
}
```

## GET /api/users/1
Returns user profile to a guest if the client requests profile of oneself.

### Example

#### Request
```
GET /api/users/2 HTTP/1.1
Accept: application/json
Access-Token: 59d72c8624a7e454561637c9814b103f9a8dd73d1662e326eb1999a32f85ba1e
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
ETag: W/"ede12f5699021aa8fe333b5113aacdec"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: b5fbd786-7f2d-46af-b017-3ef594b097ef
X-Runtime: 0.003602
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
  "created_at": "2014-12-13T21:53:03.269+09:00",
  "updated_at": "2014-12-13T21:53:03.275+09:00",
  "errors": {
  }
}
```
