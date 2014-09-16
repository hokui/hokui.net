## GET /api/users/profile
Returns self profile to an user.

### Example

#### Request
```
GET /api/users/profile HTTP/1.1
Accept: application/json
Access-Token: d589476a9c999ade03aad75e6ebfe78715c549ed1794e8cad10e89a5eb0798e5
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
X-Request-Id: 3c427e70-8355-46db-86a1-224920b07f1e
X-Runtime: 0.002292
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
X-Request-Id: 0311bed4-82b8-4bf7-962c-4e358675afa0
X-Runtime: 0.000943
X-XSS-Protection: 1; mode=block
```

## POST /api/users/activate
Successes if the guest is previously unactivated.

### Example

#### Request
```
POST /api/users/activate?email_local=guest&activation_token=ce6Y9rzx31sXppTvmpSb HTTP/1.1
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
X-Request-Id: cfa05979-cb7e-4ce3-b225-c4e5de08a180
X-Runtime: 0.002362
X-XSS-Protection: 1; mode=block
```

## GET /api/users
Returns a list of users to an admin.

### Example

#### Request
```
GET /api/users HTTP/1.1
Accept: application/json
Access-Token: abdaa8513a139425f6a75617081486ca22d28c71d46c7142cbebbb0e43ff93b9
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
X-Request-Id: d05dc39b-a3b1-4dc2-8449-6c7504692210
X-Runtime: 0.003452
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

## GET /api/users
Returns 403 to a guest.

### Example

#### Request
```
GET /api/users HTTP/1.1
Accept: application/json
Access-Token: 8eed8cb36d2adb685a08a5f801e0711defba8ef6045f6c65fdc631d16ff5cb99
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
X-Request-Id: 59e5a109-e152-4197-81d6-7cda6064ccd6
X-Runtime: 0.001861
X-XSS-Protection: 1; mode=block
```

## POST /api/users/1/approve
Successes when an admin approves a guest.

### Example

#### Request
```
POST /api/users/2/approve HTTP/1.1
Accept: application/json
Access-Token: e2295bc2a4e7f3de0d23f058983e34754dc3d251832e3aaa9ec52dd2aec45e84
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
X-Request-Id: cfe91edb-ac8f-4252-a92c-e3a3d393e126
X-Runtime: 0.003058
X-XSS-Protection: 1; mode=block
```

## POST /api/users/1/approve
Returns 403 to a guest.

### Example

#### Request
```
POST /api/users/2/approve HTTP/1.1
Accept: application/json
Access-Token: 06ba39606d69f893dd4dcdf5de272c89b0d59b8424c45b8daf5b396d7e5042f2
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
X-Request-Id: 1d49a55b-dedc-44e9-962a-4ab45342e8e7
X-Runtime: 0.002111
X-XSS-Protection: 1; mode=block
```

## GET /api/users/1
Returns user profile to an admin.

### Example

#### Request
```
GET /api/users/2 HTTP/1.1
Accept: application/json
Access-Token: 94cdf8d12be462489a2d7630d536f5b65a485ad221b5768c3054694c87aa0863
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
X-Request-Id: 90dcb492-0fa1-40a8-9d76-788857e5b03f
X-Runtime: 0.002449
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

## GET /api/users/1
Returns user profile to a guest if the client requests profile of oneself.

### Example

#### Request
```
GET /api/users/1 HTTP/1.1
Accept: application/json
Access-Token: 3ca97ba85c5c1e55d50fe56f92c7344e44fdd4c8a695c258fa8845356be15fdb
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
X-Request-Id: 974959c4-d3df-41ea-8b4e-be09b0662f57
X-Runtime: 0.002462
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
Access-Token: 31c623747a7566e2d161184a02c2cdbbee34f214ac4cbbba0004e43211abf1d3
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
X-Request-Id: 1670511e-8e25-44be-a48d-ddb71a64c81d
X-Runtime: 0.002090
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
Content-Length: 206
Content-Type: application/json; charset=utf-8
ETag: "36f9a8297e9b8b23574f54cdc93a1c87"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 292a5212-0cf4-4d71-9a21-9c90371b3690
X-Runtime: 0.144544
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
