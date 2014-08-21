## GET /api/users
Returns 403 to a guest.

### Example

#### Request
```
GET /api/users HTTP/1.1
Accept: application/json
Access-Token: 9df7f115292df5616473a5dda84def50595ae715f47bdea9360492d00010126e
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
X-Request-Id: c6785ef2-b516-4730-814f-ed66e7dc8182
X-Runtime: 0.002300
X-XSS-Protection: 1; mode=block
```

## GET /api/users
Returns a list of users to an admin.

### Example

#### Request
```
GET /api/users HTTP/1.1
Accept: application/json
Access-Token: 2b68ded9a86eb9d700dd04ff5f9daa095fda6f7f911d71aaf62c7457a097252c
Content-Length: 0
Content-Type: application/json
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 208
Content-Type: application/json; charset=utf-8
ETag: "2641063e83af129df2c45fffa834099a"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: a86b07e9-7362-4d73-87c0-e5f5836efc8d
X-Runtime: 0.003021
X-XSS-Protection: 1; mode=block

{
  "users": [
    {
      "id": 1,
      "email": "admin@ec.hokudai.ac.jp",
      "full_name": "admin admin",
      "handle_name": "admin",
      "birthday": "1990-01-01",
      "email_mobile": "admin@example.com",
      "admin": true,
      "graduation_year_id": 1,
      "errors": {
      }
    }
  ]
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
Content-Length: 206
Content-Type: application/json; charset=utf-8
ETag: "36f9a8297e9b8b23574f54cdc93a1c87"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 807fcc6a-b1c5-4180-b1de-00db6d3adabd
X-Runtime: 0.121604
X-XSS-Protection: 1; mode=block

{
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

## GET /api/users/1
Returns 403 to a guest if the client requests profile of another user.

### Example

#### Request
```
GET /api/users/1 HTTP/1.1
Accept: application/json
Access-Token: 2663d37faaf69c1b739953c15596f9d12b1fe0c534ccc2aa63fd5cb208d891ab
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
X-Request-Id: 391b8247-9aa1-415f-803f-b4495bcc1276
X-Runtime: 0.002088
X-XSS-Protection: 1; mode=block
```

## GET /api/users/1
Returns user profile to a guest if the client requests profile of oneself.

### Example

#### Request
```
GET /api/users/1 HTTP/1.1
Accept: application/json
Access-Token: 361f5eecfed407a7988ad5f878fe8490b4ac886ecd70c29cbea735cd12aa8ca5
Content-Length: 0
Content-Type: application/json
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 206
Content-Type: application/json; charset=utf-8
ETag: "36f9a8297e9b8b23574f54cdc93a1c87"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 7a576f0c-0eb5-4c42-bf14-b90de2ac8664
X-Runtime: 0.002281
X-XSS-Protection: 1; mode=block

{
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

## GET /api/users/1
Returns user profile to an admin.

### Example

#### Request
```
GET /api/users/2 HTTP/1.1
Accept: application/json
Access-Token: 5b60b9019c35ae18854b7ea4644d35b5f81e8b2d26d4070420580d37e6b086c6
Content-Length: 0
Content-Type: application/json
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 206
Content-Type: application/json; charset=utf-8
ETag: "dc5e2413a5c078ef49b1681295d9c29c"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 592bd4d6-e969-4181-a797-55e8e4d2457a
X-Runtime: 0.002243
X-XSS-Protection: 1; mode=block

{
  "user": {
    "id": 2,
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

## POST /api/users/1/approve
Returns 403 to a guest.

### Example

#### Request
```
POST /api/users/2/approve HTTP/1.1
Accept: application/json
Access-Token: 1949946eb8ba09790cb6b373a8d93b9558609019b8913c3633573a1a0aeafeea
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
X-Request-Id: bcf970ee-1c4b-49f8-883e-a3aa1b7e1542
X-Runtime: 0.002160
X-XSS-Protection: 1; mode=block
```

## POST /api/users/1/approve
Successes when an admin approves a guest.

### Example

#### Request
```
POST /api/users/2/approve HTTP/1.1
Accept: application/json
Access-Token: 18155603ece5dc8408e5f732ce7733aff2def019053afa63a98e5e4237f9103b
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
X-Request-Id: 58a95118-1015-431a-88e1-c6af128cd31e
X-Runtime: 0.002665
X-XSS-Protection: 1; mode=block
```

## GET /api/users/profile
Returns self profile to an user.

### Example

#### Request
```
GET /api/users/profile HTTP/1.1
Accept: application/json
Access-Token: de32ef47d15069a2e7563fddd294f64cd219a785ad718b5e4fe43c7324489e63
Content-Length: 0
Content-Type: application/json
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 206
Content-Type: application/json; charset=utf-8
ETag: "36f9a8297e9b8b23574f54cdc93a1c87"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 803e04b4-756b-4c43-a580-5cb9c91939eb
X-Runtime: 0.001921
X-XSS-Protection: 1; mode=block

{
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
X-Request-Id: f930aafa-3e84-4ddc-877a-dc21b53c262d
X-Runtime: 0.000973
X-XSS-Protection: 1; mode=block
```

## POST /api/users/activate
Successes if the guest is previously unactivated.

### Example

#### Request
```
POST /api/users/activate?email_local=guest&activation_token=3ATcGRfKYqscyjrCVoYU HTTP/1.1
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
X-Request-Id: 0eb04fc7-d0fd-4e65-806a-90044ac4afdf
X-Runtime: 0.002640
X-XSS-Protection: 1; mode=block
```
