## GET /api/users/1
Returns user profile to a guest if the client requests profile of oneself.

### Example

#### Request
```
GET /api/users/1 HTTP/1.1
Accept: application/json
Access-Token: baf1522a83310776695ec26d34d686a8caad2592282213d530ec2927989fdc2f
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
ETag: "8750a2ffece12c6f3541091baa333f86"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 4b6563cd-a5c5-4524-9dbb-3dde7750bfaa
X-Runtime: 0.007877
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "email": "guest@ec.hokudai.ac.jp",
  "crypted_password": "$2a$10$Xp0nv77K0TKfNuAcfxZOpuY6mpQPHWP2soGdgR9hyqSZ40OzHmVom",
  "salt": "rbo6ppqNhkbvHCdXc7Z8",
  "created_at": "2014-09-19T21:56:45.289+09:00",
  "updated_at": "2014-09-19T21:56:45.289+09:00",
  "activation_state": "pending",
  "activation_token": "eCHwyctv4foGAyaSGSF9",
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
Returns user profile to an admin.

### Example

#### Request
```
GET /api/users/2 HTTP/1.1
Accept: application/json
Access-Token: c6149327ca28a64ee3bacc440e86a68c357c18dfed44da621344c8689a144a57
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
ETag: "f91aeab4690887b06207f5b742192098"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: e2a9fcb4-c1b0-41d0-b0cd-2d7b2a3d1b77
X-Runtime: 0.002438
X-XSS-Protection: 1; mode=block

{
  "id": 2,
  "email": "guest@ec.hokudai.ac.jp",
  "crypted_password": "$2a$10$UB6Vb199RWlat92Lt4F82.7BfniW0r6LcfR8ekDFffZ4aMuDdpiFW",
  "salt": "qcTXbE6jc8E98yFY6XVq",
  "created_at": "2014-09-19T21:56:45.545+09:00",
  "updated_at": "2014-09-19T21:56:45.545+09:00",
  "activation_state": "pending",
  "activation_token": "Hf7TyUJKpvShQ6MzMKsn",
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
Returns 403 to a guest if the client requests profile of another user.

### Example

#### Request
```
GET /api/users/1 HTTP/1.1
Accept: application/json
Access-Token: 80511ede6c36409fac167d19e0b842ace3d2de757d41b6d057f7855ebdd47f84
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
X-Request-Id: b63da6ca-b7d7-4d7e-a6a5-744aa349b5bc
X-Runtime: 0.002017
X-XSS-Protection: 1; mode=block
```

## GET /api/users
Returns 403 to a guest.

### Example

#### Request
```
GET /api/users HTTP/1.1
Accept: application/json
Access-Token: bd652455be665f4019a0070c583a056c8183f868171c0074fa91de3362500ec9
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
X-Request-Id: 2c966547-d5b3-479b-8bc4-bad9ed9678c2
X-Runtime: 0.001777
X-XSS-Protection: 1; mode=block
```

## GET /api/users
Returns a list of users to an admin.

### Example

#### Request
```
GET /api/users HTTP/1.1
Accept: application/json
Access-Token: 1c9ffc13df62846a60ed791d58fb8b6c5c8aa9665be348a59b544c38b89da688
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
ETag: "15797b289ac38c266c20c9f28625c0b6"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 4a79bf78-120c-4409-af12-9596735d47b2
X-Runtime: 0.002779
X-XSS-Protection: 1; mode=block

[
  {
    "id": 1,
    "email": "admin@ec.hokudai.ac.jp",
    "crypted_password": "$2a$10$8OSkhVs95RmNCsQ/DQdL6e3seL2sl4vMNnVRyslYfhAaQSbKNHgMC",
    "salt": "mFVgqEhNkNsxVu6YqqBh",
    "created_at": "2014-09-19T21:56:46.039+09:00",
    "updated_at": "2014-09-19T21:56:46.039+09:00",
    "activation_state": "pending",
    "activation_token": "GHZPFKHTA1DU2Gvu1Fvs",
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

## POST /api/users/1/approve
Returns 403 to a guest.

### Example

#### Request
```
POST /api/users/2/approve HTTP/1.1
Accept: application/json
Access-Token: 5372a48bc551370492e42a2c65167f7830f0169a8111938dfe9ef544e2fa250c
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
X-Request-Id: ea2614b3-f3f8-4d70-8b68-03a5618937bc
X-Runtime: 0.002087
X-XSS-Protection: 1; mode=block
```

## POST /api/users/1/approve
Successes when an admin approves a guest.

### Example

#### Request
```
POST /api/users/2/approve HTTP/1.1
Accept: application/json
Access-Token: 26dd4f094934fe1e82fcbd185fe8c03a6c015b227a318170206511980d43de27
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
X-Request-Id: aefece26-e7ce-4f9a-a2f7-e19421fb4da9
X-Runtime: 0.002730
X-XSS-Protection: 1; mode=block
```

## GET /api/users/profile
Returns self profile to an user.

### Example

#### Request
```
GET /api/users/profile HTTP/1.1
Accept: application/json
Access-Token: f10aa9b1e837319171706b489e0bdb7590485e70ce45ebc7a531a162737d0c77
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
ETag: "7ac74aaab1480533993eaef59703517c"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 93b96b35-3925-4df5-8517-1fa2df5823a3
X-Runtime: 0.002020
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "email": "guest@ec.hokudai.ac.jp",
  "crypted_password": "$2a$10$73EQPifNxLcD6ug5O6vrJutHFybc2g4TqD2qr5bCIbZIaf1ri7oA2",
  "salt": "h9S7syTSqUjUW1ZkACtT",
  "created_at": "2014-09-19T21:56:46.902+09:00",
  "updated_at": "2014-09-19T21:56:46.902+09:00",
  "activation_state": "pending",
  "activation_token": "CcA5nXjjJtbYy49Rg3mf",
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
Fails if the guest is already activated.

### Example

#### Request
```
POST /api/users/activate?email_local=guest&activation_token= HTTP/1.1
Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
Content-Length: 0
Content-Type: application/x-www-form-urlencoded
Host: www.example.com
```

#### Response
```
HTTP/1.1 400
Cache-Control: no-cache
Content-Length: 1
Content-Type: text/html
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 9d29b44d-0f6d-4c11-9be8-fbf61b6a4232
X-Runtime: 0.000962
X-XSS-Protection: 1; mode=block
```

## POST /api/users/activate
Successes if the guest is previously unactivated.

### Example

#### Request
```
POST /api/users/activate?email_local=guest&activation_token=P4SepKf3xf2iavHCdVzs HTTP/1.1
Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
Content-Length: 0
Content-Type: application/x-www-form-urlencoded
Host: www.example.com
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
X-Request-Id: 52095670-8c6b-47b8-96be-b37da36e3170
X-Runtime: 0.002540
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

{"user":{"email":"guest@ec.hokudai.ac.jp","password":"guest","family_name":"guest","given_name":"guest","handle_name":"guest","birthday":"1990-01-01","email_mobile":"guest@example.com","class_year":93}}
```

#### Response
```
HTTP/1.1 201
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 736
Content-Type: application/json; charset=utf-8
ETag: "fb679f431cb42b802d7ead3f0898369a"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: cbe642c5-3f25-4b41-849b-c472ea4473d3
X-Runtime: 0.118838
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "email": "guest@ec.hokudai.ac.jp",
  "crypted_password": "$2a$10$ex5JXK6KRQp2l7Qh9kf/a..faBB8NWELsUCy/HBk/xS37QKvqGUbW",
  "salt": "hB9uE6CmqF4ggaynhBLb",
  "created_at": "2014-09-19T21:56:47.286+09:00",
  "updated_at": "2014-09-19T21:56:47.286+09:00",
  "activation_state": "pending",
  "activation_token": "ZPavxB94fsMjL3xKFnm3",
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
