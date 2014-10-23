## DELETE /api/users/1
Returns 403 to a guest.

### Example

#### Request
```
DELETE /api/users/2 HTTP/1.1
Accept: application/json
Access-Token: b1338eaa1a9e2f3e2119a4b955160975e085162dc6499634d77fcabbc597f5d3
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
X-Request-Id: 8bc45649-2cbc-4c3f-b30f-69019f7278e2
X-Runtime: 0.009175
X-XSS-Protection: 1; mode=block
```

## DELETE /api/users/1
Successes.

### Example

#### Request
```
DELETE /api/users/2 HTTP/1.1
Accept: application/json
Access-Token: c75397a62af33d97dad7358c3f668d8bd7c86338db71f4aa2d64cb878500dfe6
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
X-Request-Id: 6924dbc4-7990-4932-a37c-d2f0698536c8
X-Runtime: 0.003134
X-XSS-Protection: 1; mode=block
```

## GET /api/users/profile
Returns self profile to an user.

### Example

#### Request
```
GET /api/users/profile HTTP/1.1
Accept: application/json
Access-Token: 19b2dceba00995edee0ca5a019106999a9542d89004bbc7bfd7629e5f1a5ecb9
Content-Length: 0
Content-Type: application/json
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 392
Content-Type: application/json; charset=utf-8
ETag: "878f950cd0aa88f4b9a6777ed0842148"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 439fbc04-5baa-4fed-b283-29e1b4f85a63
X-Runtime: 0.003354
X-XSS-Protection: 1; mode=block

{
  "id": 1,
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
  "errors": {
  }
}
```

## GET /api/users/1
Returns user profile to a guest if the client requests profile of oneself.

### Example

#### Request
```
GET /api/users/1 HTTP/1.1
Accept: application/json
Access-Token: 492302e0c760933047d1e182ddf9bf763a1143bf624093378f8c9074718f971b
Content-Length: 0
Content-Type: application/json
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 392
Content-Type: application/json; charset=utf-8
ETag: "878f950cd0aa88f4b9a6777ed0842148"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 7966695c-8dee-4d88-a9c0-75ec2dff58d0
X-Runtime: 0.002448
X-XSS-Protection: 1; mode=block

{
  "id": 1,
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
Access-Token: dbd37bc20836aa5003b224b1337b73506cc999f2e1f0a596a0248f2b0b2d32ed
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
X-Request-Id: e4049209-aae0-4cc2-9ae8-ed17eeca8532
X-Runtime: 0.002076
X-XSS-Protection: 1; mode=block
```

## GET /api/users/1
Returns user profile to an admin.

### Example

#### Request
```
GET /api/users/2 HTTP/1.1
Accept: application/json
Access-Token: 3ea3aa5b49ad731af6dd47582d259946b465491deaae7efd809676af6bf82059
Content-Length: 0
Content-Type: application/json
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 392
Content-Type: application/json; charset=utf-8
ETag: "567562deb703f27dbc0fdfd16910de29"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 7805d408-7816-46be-bc46-a712bc18c803
X-Runtime: 0.002399
X-XSS-Protection: 1; mode=block

{
  "id": 2,
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
  "errors": {
  }
}
```

## POST /api/users/1/approve
Returns 403 to a guest.

### Example

#### Request
```
POST /api/users/2/approve HTTP/1.1
Accept: application/json
Access-Token: a80cf4a16e007b61f87f29917e9b8ae130137d8b912f0d2f851784d7459cfd92
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
X-Request-Id: 5955c7aa-08d3-47de-9027-c2f8d9afaa13
X-Runtime: 0.002100
X-XSS-Protection: 1; mode=block
```

## POST /api/users/1/approve
Successes when an admin approves a guest.

### Example

#### Request
```
POST /api/users/2/approve HTTP/1.1
Accept: application/json
Access-Token: 7d57d2265331e37c7fa1382176906a73f1cabd90111fdba3d4f028b9e4b27a56
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
X-Request-Id: 521c1cff-b00c-4275-8e11-dc5b158dd828
X-Runtime: 0.003394
X-XSS-Protection: 1; mode=block
```

## GET /api/users
Returns 403 to a guest.

### Example

#### Request
```
GET /api/users HTTP/1.1
Accept: application/json
Access-Token: 5514e6865b20f6c9ca7d6f10427a12c604744a6df2eadb7565355a58de0b673a
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
X-Request-Id: b135ec13-f3a1-4b21-af83-3c1d69128d58
X-Runtime: 0.001798
X-XSS-Protection: 1; mode=block
```

## GET /api/users
Returns a list of users to an admin.

### Example

#### Request
```
GET /api/users HTTP/1.1
Accept: application/json
Access-Token: 3e1ec4710e2defd2637990a3ff8462f0a96c844a8cfd2b5a5867efb1b90c8df0
Content-Length: 0
Content-Type: application/json
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 393
Content-Type: application/json; charset=utf-8
ETag: "00e51d11d470caab017d906dc8a349a1"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: b6540cc4-2d87-4c33-9228-175a7667c2c6
X-Runtime: 0.002310
X-XSS-Protection: 1; mode=block

[
  {
    "id": 1,
    "email": "admin@ec.hokudai.ac.jp",
    "activation_state": "pending",
    "approval_state": "waiting",
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
    "errors": {
    }
  }
]
```

## POST /api/users
Creates new user.

### Example

#### Request
```
POST /api/users HTTP/1.1
Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
Content-Length: 193
Content-Type: application/x-www-form-urlencoded
Host: www.example.com

{"email":"guest@ec.hokudai.ac.jp","password":"guest","family_name":"guest","given_name":"guest","handle_name":"guest","birthday":"1990-01-01","email_mobile":"guest@example.com","class_year":93}
```

#### Response
```
HTTP/1.1 201
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 392
Content-Type: application/json; charset=utf-8
ETag: "878f950cd0aa88f4b9a6777ed0842148"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: dcbc6612-9eeb-45d4-8628-8faad4b043c8
X-Runtime: 0.141246
X-XSS-Protection: 1; mode=block

{
  "id": 1,
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
  "errors": {
  }
}
```

## POST /api/users/activate
Fails if the guest is already activated.

### Example

#### Request
```
POST /api/users/activate HTTP/1.1
Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
Content-Length: 65
Content-Type: application/x-www-form-urlencoded
Host: www.example.com

{"email_local":"guest","activation_token":"Ykm9kmd92BzsuxDp14qJ"}
```

#### Response
```
HTTP/1.1 400
Cache-Control: no-cache
Content-Length: 1
Content-Type: text/html
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: db371679-92d6-4d10-a823-158d25c97db4
X-Runtime: 0.001439
X-XSS-Protection: 1; mode=block
```

## POST /api/users/activate
Successes if the guest is previously unactivated.

### Example

#### Request
```
POST /api/users/activate HTTP/1.1
Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
Content-Length: 65
Content-Type: application/x-www-form-urlencoded
Host: www.example.com

{"email_local":"guest","activation_token":"sqzrwYwzAYpGfwnHsmdP"}
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 1
Content-Type: text/html
ETag: "7215ee9c7d9dc229d2921a40e899ec5f"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: cefc993f-55d8-461d-9cc1-ed2932ee96ba
X-Runtime: 0.002277
X-XSS-Protection: 1; mode=block
```
