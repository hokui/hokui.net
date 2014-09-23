## GET /api/users/1
Returns user profile to an admin.

### Example

#### Request
```
GET /api/users/2 HTTP/1.1
Accept: application/json
Access-Token: 4a33ac2538420b78536a9327d9d7a7422b1e49ee68f009402f5109924694c646
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
ETag: "e593498265f924989cc96666e7812e49"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: df55e24f-d49d-460e-af63-2e6e89476f26
X-Runtime: 0.004587
X-XSS-Protection: 1; mode=block

{
  "id": 2,
  "email": "guest@ec.hokudai.ac.jp",
  "crypted_password": "$2a$10$3jnSrbL3163MhJBGcC9OXuQsxDsAVM5qjoDhi9LvL0VxE1fMXRTl.",
  "salt": "igrayyz2VnYHy7mpjuwx",
  "created_at": "2014-09-23T22:34:48.131+09:00",
  "updated_at": "2014-09-23T22:34:48.131+09:00",
  "activation_state": "pending",
  "activation_token": "TE6qor57R5WrfMMQFhy8",
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
Access-Token: 6ee5ad46504a29bed1e21f5ff2387a5a76f9c8ae8c724ab8cddaf1459b4a1f04
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
ETag: "936f9c26340af75c10e578754b26e2d6"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 5e6262c0-df85-49fb-885a-a5b0ea8bca72
X-Runtime: 0.002633
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "email": "guest@ec.hokudai.ac.jp",
  "crypted_password": "$2a$10$1HPtinNjkjyVDTRswFQvauAwwz9gKydMlH6AT8zv.fxc53y/4kXEW",
  "salt": "zUe5o5esMi9MASif1sp8",
  "created_at": "2014-09-23T22:34:48.266+09:00",
  "updated_at": "2014-09-23T22:34:48.266+09:00",
  "activation_state": "pending",
  "activation_token": "m8SCut3c2aMPoWahwwdq",
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
Access-Token: 57899830130fba4508cc66cb63520cd2e988b8d8f48a181d53afb4de6963ebe5
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
X-Request-Id: 86ae7b52-50e3-496e-9509-50743ef038f7
X-Runtime: 0.002093
X-XSS-Protection: 1; mode=block
```

## GET /api/users/profile
Returns self profile to an user.

### Example

#### Request
```
GET /api/users/profile HTTP/1.1
Accept: application/json
Access-Token: 797d46d4f8c5624bf086ef92c2c048ec795d5414f22a671e59ab684e2383cef3
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
ETag: "a1fc22990a3b32004de70f12f5cd3812"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 92a993a2-ceb0-4d27-9a28-2e0e23dc7e67
X-Runtime: 0.002119
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "email": "guest@ec.hokudai.ac.jp",
  "crypted_password": "$2a$10$MlTQhIqfjU/rrFrtvKJkKes69TzvCudf0WFFVxtHdQlqFOeBZHHze",
  "salt": "nbQJFiWRuto1xyY6PJFy",
  "created_at": "2014-09-23T22:34:48.653+09:00",
  "updated_at": "2014-09-23T22:34:48.653+09:00",
  "activation_state": "pending",
  "activation_token": "hZf9SUSohY3KKAUEqzbn",
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
ETag: "a3dfee1200b23f811e816400d2bfefc0"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 6ebd8e59-3af4-4a82-ba6f-d1cbbb87341b
X-Runtime: 0.124911
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "email": "guest@ec.hokudai.ac.jp",
  "crypted_password": "$2a$10$VQtjPZI83HIWwuZRt4.Cfe4VmbsvgAqtvnf0pH09p22k6K4ZE6yry",
  "salt": "GoBJrLpmsLvkG81rx8j6",
  "created_at": "2014-09-23T22:34:48.804+09:00",
  "updated_at": "2014-09-23T22:34:48.804+09:00",
  "activation_state": "pending",
  "activation_token": "3d1jHTvNcDshZKyBA4WM",
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
POST /api/users/activate HTTP/1.1
Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
Content-Length: 65
Content-Type: application/x-www-form-urlencoded
Host: www.example.com

{"email_local":"guest","activation_token":"nzLpdvzPMdwNyXd24sfq"}
```

#### Response
```
HTTP/1.1 400
Cache-Control: no-cache
Content-Length: 1
Content-Type: text/html
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 3ceecf00-ce28-4186-8dd3-430fb324e35c
X-Runtime: 0.001452
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

{"email_local":"guest","activation_token":"qzkpD71upbd9WUGdYSnS"}
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
X-Request-Id: b896bb8f-efc0-4885-ab43-31fa3ecc88f9
X-Runtime: 0.002351
X-XSS-Protection: 1; mode=block
```

## GET /api/users
Returns a list of users to an admin.

### Example

#### Request
```
GET /api/users HTTP/1.1
Accept: application/json
Access-Token: 0a3b921657adfa813eae1b3fe2a5232fe3dd5fdd1dc8450dea7b275f8d735006
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
ETag: "be834d989b29e29176b6cabaea6fd1c0"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 8b60ae81-8e8b-44e7-be7d-521decf9696f
X-Runtime: 0.002622
X-XSS-Protection: 1; mode=block

[
  {
    "id": 1,
    "email": "admin@ec.hokudai.ac.jp",
    "crypted_password": "$2a$10$Y1GXd58DLkph4lSRrfUCVeJvYebZtkMFq.LPNHIJkcCtrfh6hCbVS",
    "salt": "L7yHRqJZTdazJabfo8bi",
    "created_at": "2014-09-23T22:34:49.182+09:00",
    "updated_at": "2014-09-23T22:34:49.182+09:00",
    "activation_state": "pending",
    "activation_token": "eajBfHy6yDFHMykcmLUb",
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
Access-Token: 755ee22594a937caa11d9e916fbe86c1c665a2e0689f455214e0d174e1c5e704
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
X-Request-Id: 22af7f62-94f5-4853-9c1e-a75b2494e0e7
X-Runtime: 0.001776
X-XSS-Protection: 1; mode=block
```

## POST /api/users/1/approve
Successes when an admin approves a guest.

### Example

#### Request
```
POST /api/users/2/approve HTTP/1.1
Accept: application/json
Access-Token: 27e85f85c54e47f5ce36071a3d7ad739eab421f89ee4d259b8bbde9a30549cb2
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
X-Request-Id: b5ea9f99-0248-4842-8e00-d74f4a9056df
X-Runtime: 0.002955
X-XSS-Protection: 1; mode=block
```

## POST /api/users/1/approve
Returns 403 to a guest.

### Example

#### Request
```
POST /api/users/2/approve HTTP/1.1
Accept: application/json
Access-Token: d1fbb0f34abe84f348a962f4d31fdc5fb773292037b7ab8d3b6ea27440a59416
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
X-Request-Id: 97f615b4-18d6-4bef-adb9-60531732b2ed
X-Runtime: 0.001994
X-XSS-Protection: 1; mode=block
```

## DELETE /api/users/1
Successes.

### Example

#### Request
```
DELETE /api/users/2 HTTP/1.1
Accept: application/json
Access-Token: 49f005d2718918b6af321b439dd84323d2a730b34c448ada9e6775c5259183e5
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
X-Request-Id: c9d52d96-655b-4f58-8bfb-a97d79d4ff44
X-Runtime: 0.003137
X-XSS-Protection: 1; mode=block
```

## DELETE /api/users/1
Returns 403 to a guest.

### Example

#### Request
```
DELETE /api/users/2 HTTP/1.1
Accept: application/json
Access-Token: 2cbd114cbb754e2576ffbedb4197b345c89d39b621b4b62eeea5a0b2f721a6ea
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
X-Request-Id: 485f9645-5cc7-491d-a8da-3c493b585e6a
X-Runtime: 0.002114
X-XSS-Protection: 1; mode=block
```
