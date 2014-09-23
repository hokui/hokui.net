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

{"user":{"email":"guest@ec.hokudai.ac.jp","password":"guest","family_name":"guest","given_name":"guest","handle_name":"guest","birthday":"1990-01-01","email_mobile":"guest@example.com","class_year":93}}
```

#### Response
```
HTTP/1.1 201
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 736
Content-Type: application/json; charset=utf-8
ETag: "5a0c955e484f212c9bcb4321fd67017c"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 24620ad6-4d61-4857-b0b2-8ccc67e6c6f9
X-Runtime: 0.207417
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "email": "guest@ec.hokudai.ac.jp",
  "crypted_password": "$2a$10$NKR6Oy0JwLmL.NjxlxOnau3kmepb6UekmBxWs7UVG9fSvozU2TgTa",
  "salt": "Fs9dqth2sas6q8vk9MtH",
  "created_at": "2014-09-23T22:46:26.781+09:00",
  "updated_at": "2014-09-23T22:46:26.781+09:00",
  "activation_state": "pending",
  "activation_token": "H9M64zs8a8wTpCa8rvrQ",
  "activation_token_expires_at": null,
  "approval_state": "waiting",
  "reset_password_token": null,
  "reset_password_token_expires_at": null,
  "reset_password_email_sent_at": null,
  "last_login_at": null,
  "last_logout_at": null,
  "last_activity_at": null,
  "last_login_from_ip_address": null,
  "family_name": "guest",
  "given_name": "guest",
  "handle_name": "guest",
  "birthday": "1990-01-01",
  "email_mobile": "guest@example.com",
  "admin": false,
  "class_year_id": 1
}
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

{"email_local":"guest","activation_token":"yWSsi2FiQTAyL8j8wnhT"}
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
X-Request-Id: 497aea6a-db9a-4f1e-8611-5a54a67714a9
X-Runtime: 0.003979
X-XSS-Protection: 1; mode=block
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

{"email_local":"guest","activation_token":"RS1rBGosGvZWY1gccxzV"}
```

#### Response
```
HTTP/1.1 400
Cache-Control: no-cache
Content-Length: 1
Content-Type: text/html
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 7a4fd8c0-b815-4332-a9ce-98f5aa7aa734
X-Runtime: 0.002755
X-XSS-Protection: 1; mode=block
```

## DELETE /api/users/1
Successes.

### Example

#### Request
```
DELETE /api/users/2 HTTP/1.1
Accept: application/json
Access-Token: a3b1d1c2cd8bfb58b77b03ed79f011018b1454940b815318d7955e8de8a5f932
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
X-Request-Id: 1566236d-f043-48be-bda5-1f00aca2a633
X-Runtime: 0.005516
X-XSS-Protection: 1; mode=block
```

## DELETE /api/users/1
Returns 403 to a guest.

### Example

#### Request
```
DELETE /api/users/2 HTTP/1.1
Accept: application/json
Access-Token: 40161bdca69884f9e1708cbc1f3e339cf064ef829e57dcf9c78b12a52758b93e
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
X-Request-Id: 835cdd6d-26ad-4216-ab70-1a04bcbfb008
X-Runtime: 0.003090
X-XSS-Protection: 1; mode=block
```

## GET /api/users/1
Returns 403 to a guest if the client requests profile of another user.

### Example

#### Request
```
GET /api/users/1 HTTP/1.1
Accept: application/json
Access-Token: a42ea4730b3bb05fd4a9ee70ff57ac52ddcfb3499b9f90e9c698026c594f9036
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
X-Request-Id: cdc3e92a-516e-4420-a157-96dc33967e57
X-Runtime: 0.003689
X-XSS-Protection: 1; mode=block
```

## GET /api/users/1
Returns user profile to an admin.

### Example

#### Request
```
GET /api/users/2 HTTP/1.1
Accept: application/json
Access-Token: ab3340b008024dac7bb4e5225a35189dac124e8893e76db16a1fa6a7b59e5561
Content-Length: 0
Content-Type: application/json
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 736
Content-Type: application/json; charset=utf-8
ETag: "e54b220d9616fb3725a7a571b5f8013e"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: c264717e-8999-4575-a495-4189253bf2eb
X-Runtime: 0.003920
X-XSS-Protection: 1; mode=block

{
  "id": 2,
  "email": "guest@ec.hokudai.ac.jp",
  "crypted_password": "$2a$10$S4AZLywmpbmEWETZ8WwBxOOii71.L9EoHaQ84DC5VfzD3AJxe3ew6",
  "salt": "xAH6wkriTDc9yCNFcNrn",
  "created_at": "2014-09-23T22:46:29.108+09:00",
  "updated_at": "2014-09-23T22:46:29.108+09:00",
  "activation_state": "pending",
  "activation_token": "eUiHsw8fkqAnr9QP5n6e",
  "activation_token_expires_at": null,
  "approval_state": "waiting",
  "reset_password_token": null,
  "reset_password_token_expires_at": null,
  "reset_password_email_sent_at": null,
  "last_login_at": null,
  "last_logout_at": null,
  "last_activity_at": null,
  "last_login_from_ip_address": null,
  "family_name": "guest",
  "given_name": "guest",
  "handle_name": "guest",
  "birthday": "1990-01-01",
  "email_mobile": "guest@example.com",
  "admin": false,
  "class_year_id": 1
}
```

## GET /api/users/1
Returns user profile to a guest if the client requests profile of oneself.

### Example

#### Request
```
GET /api/users/1 HTTP/1.1
Accept: application/json
Access-Token: a0b6f62aed09d7c1ec91aa28208c7ea25b5daa547beaec6139cc69d9fa4d879d
Content-Length: 0
Content-Type: application/json
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 736
Content-Type: application/json; charset=utf-8
ETag: "b0a52bbf80de9002e7495e99ee9e1474"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 402bb6ab-ca43-4a8a-9699-a98645e6faa2
X-Runtime: 0.003870
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "email": "guest@ec.hokudai.ac.jp",
  "crypted_password": "$2a$10$93Sj8jHlUsSB18J6r/S/he8rFiBM1kZdJDlgESTVept2h1kwQzf/O",
  "salt": "bHB3m6XczqBXugyxWozy",
  "created_at": "2014-09-23T22:46:29.322+09:00",
  "updated_at": "2014-09-23T22:46:29.322+09:00",
  "activation_state": "pending",
  "activation_token": "VKNDGYgKLx3RFvyHJ7My",
  "activation_token_expires_at": null,
  "approval_state": "waiting",
  "reset_password_token": null,
  "reset_password_token_expires_at": null,
  "reset_password_email_sent_at": null,
  "last_login_at": null,
  "last_logout_at": null,
  "last_activity_at": null,
  "last_login_from_ip_address": null,
  "family_name": "guest",
  "given_name": "guest",
  "handle_name": "guest",
  "birthday": "1990-01-01",
  "email_mobile": "guest@example.com",
  "admin": false,
  "class_year_id": 1
}
```

## GET /api/users
Returns a list of users to an admin.

### Example

#### Request
```
GET /api/users HTTP/1.1
Accept: application/json
Access-Token: 8ad114dcdbb947166e0f0c8a1cd6d3ad4de1390c04c50fb0b63efdfd326718dd
Content-Length: 0
Content-Type: application/json
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 737
Content-Type: application/json; charset=utf-8
ETag: "c85e0ed51fc690916c5f666af48f88a1"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 1f341cee-03cb-4814-8c0c-17c13387b51e
X-Runtime: 0.004687
X-XSS-Protection: 1; mode=block

[
  {
    "id": 1,
    "email": "admin@ec.hokudai.ac.jp",
    "crypted_password": "$2a$10$AKkd52C13Akb8Ji1TtL57O0E3gykdZb3taJS9H5HgJSgOoW091rmu",
    "salt": "9RiL9Sybxo4BcqXfAqex",
    "created_at": "2014-09-23T22:46:29.541+09:00",
    "updated_at": "2014-09-23T22:46:29.541+09:00",
    "activation_state": "pending",
    "activation_token": "naeeszCPwsqCbqSTuzQv",
    "activation_token_expires_at": null,
    "approval_state": "waiting",
    "reset_password_token": null,
    "reset_password_token_expires_at": null,
    "reset_password_email_sent_at": null,
    "last_login_at": null,
    "last_logout_at": null,
    "last_activity_at": null,
    "last_login_from_ip_address": null,
    "family_name": "admin",
    "given_name": "admin",
    "handle_name": "admin",
    "birthday": "1990-01-01",
    "email_mobile": "admin@example.com",
    "admin": true,
    "class_year_id": 1
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
Access-Token: 8dddb8d6c07f602dfd2979f781d9701a165eb198838f535e7e3f5599225fdecc
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
X-Request-Id: a28a553c-99d1-496a-a9f8-c89e3beb334c
X-Runtime: 0.003267
X-XSS-Protection: 1; mode=block
```

## GET /api/users/profile
Returns self profile to an user.

### Example

#### Request
```
GET /api/users/profile HTTP/1.1
Accept: application/json
Access-Token: df917811774758169c1dbaf2d8104a30fc835842aba558f1b8a76c1bc28914fb
Content-Length: 0
Content-Type: application/json
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 736
Content-Type: application/json; charset=utf-8
ETag: "d54dc2ec8b9099764011cbcc61cf5f63"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 9211455a-0b20-4f43-9678-ae25d4ca54ea
X-Runtime: 0.005119
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "email": "guest@ec.hokudai.ac.jp",
  "crypted_password": "$2a$10$g8ujLmuC7PGUVqRagUNb6u5oCOevJleGJ7ug7OMinTeCVBnw3BN7a",
  "salt": "dgTqVWMqgX2xqwRjpWtd",
  "created_at": "2014-09-23T22:46:29.987+09:00",
  "updated_at": "2014-09-23T22:46:29.987+09:00",
  "activation_state": "pending",
  "activation_token": "SYbed8jiWxGAzzwjFjMp",
  "activation_token_expires_at": null,
  "approval_state": "waiting",
  "reset_password_token": null,
  "reset_password_token_expires_at": null,
  "reset_password_email_sent_at": null,
  "last_login_at": null,
  "last_logout_at": null,
  "last_activity_at": null,
  "last_login_from_ip_address": null,
  "family_name": "guest",
  "given_name": "guest",
  "handle_name": "guest",
  "birthday": "1990-01-01",
  "email_mobile": "guest@example.com",
  "admin": false,
  "class_year_id": 1
}
```

## POST /api/users/1/approve
Successes when an admin approves a guest.

### Example

#### Request
```
POST /api/users/2/approve HTTP/1.1
Accept: application/json
Access-Token: 441ee692eaff6f38221363bf7d6d260f428b375b8cfea0b6e29f1128c41e1e47
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
X-Request-Id: 8482e434-1441-4283-93f9-ef3eca069bb6
X-Runtime: 0.004556
X-XSS-Protection: 1; mode=block
```

## POST /api/users/1/approve
Returns 403 to a guest.

### Example

#### Request
```
POST /api/users/2/approve HTTP/1.1
Accept: application/json
Access-Token: 3fa0b47729e1dc6c4d25346bc3478266f3358e1d381ff830a8ce2d5324a7c98e
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
X-Request-Id: f201c1fa-8b72-4bdb-ba6d-ea30c51921a3
X-Runtime: 0.002992
X-XSS-Protection: 1; mode=block
```
