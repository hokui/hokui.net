## GET /api/class_years/1
Returns class year.

### Example

#### Request
```
GET /api/class_years/1 HTTP/1.1
Accept: application/json
Access-Token: c8f0544a2345ec1c813e792c0e18d476e2882b14140d3ef1034fd53edeed0ebd
Content-Length: 0
Content-Type: application/json
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 108
Content-Type: application/json; charset=utf-8
ETag: "b86549aa523067460312fdc721fee64c"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: ec24af57-48ad-4c34-971c-75ae4156da97
X-Runtime: 0.002734
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "year": 93,
  "created_at": "2014-09-23T22:34:45.650+09:00",
  "updated_at": "2014-09-23T22:34:45.650+09:00"
}
```

## PATCH 
Updates class year.

### Example

#### Request
```
PATCH /api/class_years/1 HTTP/1.1
Accept: application/json
Access-Token: 15b9d53f350af587ba1a88a38d0f350bd535ab336806b5345df990cd0255fef5
Content-Length: 26
Content-Type: application/json
Host: www.example.com

{
  "class_year": {
    "year": 94
  }
}
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
X-Request-Id: 44511628-7e01-4e0d-9cd9-50379e37e704
X-Runtime: 0.005569
X-XSS-Protection: 1; mode=block
```

## POST /api/class_years
Creates new class year.

### Example

#### Request
```
POST /api/class_years HTTP/1.1
Accept: application/json
Access-Token: 536c13b6c2ee82712786b0270ae726320420bccf9206b233eb7621e4ef5ef3b8
Content-Length: 26
Content-Type: application/json
Host: www.example.com

{
  "class_year": {
    "year": 93
  }
}
```

#### Response
```
HTTP/1.1 201
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 108
Content-Type: application/json; charset=utf-8
ETag: "16754111af2d578270acdc1b29cedb44"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: b61c9640-431b-4a0e-9858-1bf4a15557f3
X-Runtime: 0.003577
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "year": 93,
  "created_at": "2014-09-23T22:34:46.223+09:00",
  "updated_at": "2014-09-23T22:34:46.223+09:00"
}
```

## DELETE /api/class_years/1
Destroys specified record.

### Example

#### Request
```
DELETE /api/class_years/1 HTTP/1.1
Accept: application/json
Access-Token: ea548df2de79a59e75fe88afd9ac0ce3a75357117b73e896eb43dd235771615d
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
X-Request-Id: 9cb7fd08-d53e-4780-9c5b-375986aa1057
X-Runtime: 0.002824
X-XSS-Protection: 1; mode=block
```

## GET /api/class_years
Returns a list of class years.

### Example

#### Request
```
GET /api/class_years HTTP/1.1
Accept: application/json
Access-Token: af98d2c46a418efcbf7a1d21cfded5826723ea3abafc4accdf676a34aaf2e7e8
Content-Length: 0
Content-Type: application/json
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 2
Content-Type: application/json; charset=utf-8
ETag: "d751713988987e9331980363e24189ce"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 1bd16aa0-3c0e-4532-b5db-8e98323a6d3e
X-Runtime: 0.002044
X-XSS-Protection: 1; mode=block

[

]
```
