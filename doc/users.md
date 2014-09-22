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
ETag: "e52cb45f831546588428c88303b6f023"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 6a904aa2-fd22-4fbd-9868-2bb43d0d05c7
X-Runtime: 0.198385
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "email": "guest@ec.hokudai.ac.jp",
  "crypted_password": "$2a$10$yBhSLqLAyVkBvKu/.Qrs5O5/aTjDKivfgjxZ2kE50deI0C6MhEuQu",
  "salt": "9CAYL4mRcqBbvkgwPqAd",
  "created_at": "2014-09-22T11:31:52.940+09:00",
  "updated_at": "2014-09-22T11:31:52.940+09:00",
  "activation_state": "pending",
  "activation_token": "UhvvEJPS7p6mBHkiYEAj",
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
Access-Token: 85306eb05827d704d9a68ad5e44fd8db4b6eb77903aec91bb27a9b096e50596c
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
ETag: "3536f115ffdc9b22c490dca1a99673c2"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 69c39469-b082-4b9e-aad2-392234dce804
X-Runtime: 0.007436
X-XSS-Protection: 1; mode=block

[
  {
    "id": 1,
    "email": "admin@ec.hokudai.ac.jp",
    "crypted_password": "$2a$10$rIS4QC0sXQ6NmbGE6W.R5.zlgml5YDhhjLkGV1D7j2fN7AtEBMsia",
    "salt": "P5A336sYq5NoyVpzTMYA",
    "created_at": "2014-09-22T11:31:53.135+09:00",
    "updated_at": "2014-09-22T11:31:53.135+09:00",
    "activation_state": "pending",
    "activation_token": "qXSkkaMBm9kxGtLzoRKe",
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
Access-Token: 63046f5d17dcda5fc8fcd3d1b77d453f35aa2ada1c144bdbac9815b43f41524f
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
X-Request-Id: 566716fc-14b1-490c-8237-bd3836f9ae18
X-Runtime: 0.004154
X-XSS-Protection: 1; mode=block
```

## POST /api/users/1/approve
Successes when an admin approves a guest.

### Example

#### Request
```
POST /api/users/2/approve HTTP/1.1
Accept: application/json
Access-Token: 413070d5c00108a16425013404bc832b6204f8eaed99a82412ac2087a0d56480
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
X-Request-Id: 1774262c-4683-484c-8126-7e449a9670d4
X-Runtime: 0.008738
X-XSS-Protection: 1; mode=block
```

## POST /api/users/1/approve
Returns 403 to a guest.

### Example

#### Request
```
POST /api/users/2/approve HTTP/1.1
Accept: application/json
Access-Token: c34f35bba87ca85f912bab4292ab3c7e9af69c72420ddb178516b9feea52014d
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
X-Request-Id: 65a916f3-1172-43f2-b67a-90df5deddc02
X-Runtime: 0.004844
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

{"email_local":"guest","activation_token":"CgEpYy3ApVpW1xKqgrRx"}
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
X-Request-Id: 89e25e43-8399-4322-8275-6ceb37517fce
X-Runtime: 0.006210
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

{"email_local":"guest","activation_token":"je8eda4daEHLCe8nsYAL"}
```

#### Response
```
HTTP/1.1 400
Cache-Control: no-cache
Content-Length: 1
Content-Type: text/html
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 0c47f72b-77f5-45f5-a6b9-d057dbafdd53
X-Runtime: 0.002814
X-XSS-Protection: 1; mode=block
```

## GET /api/users/1
Returns user profile to an admin.

### Example

#### Request
```
GET /api/users/2 HTTP/1.1
Accept: application/json
Access-Token: a43d67d9ac9e79a232397eb96996a64bf2614d5dc0615993bdb91b603c6efe28
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
ETag: "9de9ed08a83825b19101b14da6add500"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: c93be69b-36d9-4e6e-be77-ee5779ab06ce
X-Runtime: 0.006244
X-XSS-Protection: 1; mode=block

{
  "id": 2,
  "email": "guest@ec.hokudai.ac.jp",
  "crypted_password": "$2a$10$Vx9teBwD7Y5ISAySn/yix.XcLaLqbA2VuEBSDYm5je1nkY/oVwsZq",
  "salt": "1sEHdqmjUzTfhqEvPvLG",
  "created_at": "2014-09-22T11:31:55.087+09:00",
  "updated_at": "2014-09-22T11:31:55.087+09:00",
  "activation_state": "pending",
  "activation_token": "SozwN7rLsMsXfsnK2Vsn",
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
Access-Token: 9fce3353c956388d843d138e63f96e0670471e8baa2878e47dab85ab0d2cd566
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
X-Request-Id: 4d115e51-0a8d-476f-999d-4d3eebbdf552
X-Runtime: 0.004875
X-XSS-Protection: 1; mode=block
```

## GET /api/users/1
Returns user profile to a guest if the client requests profile of oneself.

### Example

#### Request
```
GET /api/users/1 HTTP/1.1
Accept: application/json
Access-Token: d1f5101ce48331a0e90a565698a89246ab83c57ec6b684a09a1fb5f077083fbc
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
ETag: "91fe35cbdaba295bc3e0a83602a18abb"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: d9c5b335-b043-4bb7-abdb-77901c04a031
X-Runtime: 0.005781
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "email": "guest@ec.hokudai.ac.jp",
  "crypted_password": "$2a$10$O8L7RWTmNLD2g4STSqQ3FOqvaagjacePaUk1uzinWk8uEVNSBJFvO",
  "salt": "AcFTNRoBH7ykeiEfqdyP",
  "created_at": "2014-09-22T11:31:55.625+09:00",
  "updated_at": "2014-09-22T11:31:55.625+09:00",
  "activation_state": "pending",
  "activation_token": "kX4rJxYdyuPwuo17Xayb",
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

## GET /api/users/profile
Returns self profile to an user.

### Example

#### Request
```
GET /api/users/profile HTTP/1.1
Accept: application/json
Access-Token: 32f954c485d796bde81dbc3335647c33e4b58cdf7aacb6e0dd3190f184ad2dc1
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
ETag: "35796a4f6e230d6b480f3e2c0af9e0c5"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: c4016fc1-75ff-465a-9f4a-7aaab776fbb8
X-Runtime: 0.005150
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "email": "guest@ec.hokudai.ac.jp",
  "crypted_password": "$2a$10$aGcHd7vt1liPhMhEucwDkeCTNHbQ.8vV3u4iIi8BASNkNcGz5ZlKC",
  "salt": "KTMG8pV9MQnuB5QCoTS5",
  "created_at": "2014-09-22T11:31:55.810+09:00",
  "updated_at": "2014-09-22T11:31:55.810+09:00",
  "activation_state": "pending",
  "activation_token": "sB2kKeXxsnxvzs1oEPWG",
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
