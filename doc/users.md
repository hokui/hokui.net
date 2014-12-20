## GET /api/users
Returns a list of users to an admin.

### Example

#### Request
```
GET /api/users HTTP/1.1
Accept: application/json
Access-Token: 50dd29987e895dcf7fcd6ab100f256153f92f5a9e4f67846f07230bb3a9bff72
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
ETag: W/"0c746b84ea6934da679db89cc6e42ebf"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 8aca871a-51ab-4855-8447-041fa6d6d062
X-Runtime: 0.003700
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
    "created_at": "2014-12-20T12:15:07.222+09:00",
    "updated_at": "2014-12-20T12:15:07.228+09:00",
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
Access-Token: 92d658747ad35bd189ca1f9a4199a3f4bceb0cded7c1cfad271ebb13c1b7e946
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
X-Request-Id: d0a0d7a9-545d-44b9-ae5d-c1de688bdea6
X-Runtime: 0.001835
X-XSS-Protection: 1; mode=block
```

## GET /api/users/1
Returns user profile to an admin.

### Example

#### Request
```
GET /api/users/2 HTTP/1.1
Accept: application/json
Access-Token: b7535352bfb3fb6eadff80acf064ebf41da16fdce1da329151d8ba36c7898ac5
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
ETag: W/"f4ccb88e0ef5b6cc811f86501b912c0e"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 8c72099d-03e8-462e-abcf-9f095394e9ad
X-Runtime: 0.003450
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
  "created_at": "2014-12-20T12:15:07.641+09:00",
  "updated_at": "2014-12-20T12:15:07.646+09:00",
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
Access-Token: 3ec80f7042b6fb5c8774fb46bbde3e26a74bf3f1ef4910d60519c9c83b54efe4
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
ETag: W/"d0c61784aab89900e3b02136326d77ce"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 459e3f89-9c8a-4be0-802c-942ba3da40a0
X-Runtime: 0.003240
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
  "created_at": "2014-12-20T12:15:07.768+09:00",
  "updated_at": "2014-12-20T12:15:07.774+09:00",
  "errors": {
  }
}
```

## GET /api/users/1
Returns 403 to a guest if the client requests profile of another user.

### Example

#### Request
```
GET /api/users/1 HTTP/1.1
Accept: application/json
Access-Token: f2dc75ab6289ce8655270fcdeb4262d29abbe35659befeb2425e1ea8c42ee203
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
X-Request-Id: fa8af05e-e3ba-47b3-8506-b10ee7632bff
X-Runtime: 0.001939
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
ETag: W/"5336c988efba0628bfad79ccc63db471"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 6027eaa1-8d5e-4348-bbbf-44e3bbaf1f6d
X-Runtime: 0.118829
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
  "created_at": "2014-12-20T12:15:08.152+09:00",
  "updated_at": "2014-12-20T12:15:08.152+09:00",
  "errors": {
  }
}
```

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

{"activation_token":"pZmiz69Jx8jSQuGAMjWs"}
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
X-Request-Id: 5a6570cd-da6e-4536-a614-f09bf66d76d8
X-Runtime: 0.003329
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

{"activation_token":"eZTHowyuxpEMDjxtbnZ9"}
```

#### Response
```
HTTP/1.1 400
Cache-Control: no-cache
Content-Length: 1
Content-Type: text/html
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 72bf5fb4-f43e-42a9-98d4-323c54f61ece
X-Runtime: 0.001455
X-XSS-Protection: 1; mode=block
```

## POST /api/users/1/approve
Successes when an admin approves a guest.

### Example

#### Request
```
POST /api/users/2/approve HTTP/1.1
Accept: application/json
Access-Token: e5f1c96a3383fcf8722aaeeca9823732bce7aa9cb054601cbb84ea8a70b53ecd
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
X-Request-Id: 80101dd7-e9e3-4477-84cd-a5eb54d9978b
X-Runtime: 0.003514
X-XSS-Protection: 1; mode=block
```

## POST /api/users/1/approve
Returns 403 to a guest.

### Example

#### Request
```
POST /api/users/2/approve HTTP/1.1
Accept: application/json
Access-Token: 15e839c2c6e53c9c728786b1ec829be61b702ac2c51b4015ec3accad7c6ac439
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
X-Request-Id: 01128963-c15d-47f4-989a-bea9a24e4aef
X-Runtime: 0.002010
X-XSS-Protection: 1; mode=block
```

## DELETE /api/users/1
Successes.

### Example

#### Request
```
DELETE /api/users/2 HTTP/1.1
Accept: application/json
Access-Token: 631871b4e9d967b4a0dff21cea073e55a50599310f8e1d70a2a3e9bb8cc390bf
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
X-Request-Id: 701f0b10-9a69-476f-88cb-c29a8696d01f
X-Runtime: 0.003852
X-XSS-Protection: 1; mode=block
```

## DELETE /api/users/1
Returns 403 to a guest.

### Example

#### Request
```
DELETE /api/users/1 HTTP/1.1
Accept: application/json
Access-Token: bdf8673e2c8a9ba4aed5732c187593a73b5a6b3f0d7d02f71ab930087ef89122
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
X-Request-Id: 82cca113-1f43-4520-88b9-25bddb39bc91
X-Runtime: 0.001883
X-XSS-Protection: 1; mode=block
```
