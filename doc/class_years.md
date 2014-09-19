## PATCH 
Updates class year.

### Example

#### Request
```
PATCH /api/class_years/1 HTTP/1.1
Accept: application/json
Access-Token: 4090dde736912b395e306fbb055c01434c43a396a91c05b6d71641300422009a
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
X-Request-Id: 64c77091-3d7b-4d71-ab50-fac2fe8d0cfe
X-Runtime: 0.004470
X-XSS-Protection: 1; mode=block
```

## GET /api/class_years/1
Returns class year.

### Example

#### Request
```
GET /api/class_years/1 HTTP/1.1
Accept: application/json
Access-Token: 8ac682f38075c3a746a822e489cff21158a19dac5c468c47e3edd1faffd4b084
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
ETag: "662953390fd2a977fd48717e7a52b5b9"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 0c29fc36-babe-4d6f-a229-530afe869479
X-Runtime: 0.002216
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "year": 93,
  "created_at": "2014-09-19T21:56:47.561+09:00",
  "updated_at": "2014-09-19T21:56:47.561+09:00"
}
```

## GET /api/class_years
Returns a list of class years.

### Example

#### Request
```
GET /api/class_years HTTP/1.1
Accept: application/json
Access-Token: f2b45c721b8349ae4e9626e5ab55b8d17a10ee27510e786adfb7a7231e7b2796
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
X-Request-Id: c8d47de4-0405-46f8-8d72-6857c94ea90f
X-Runtime: 0.001841
X-XSS-Protection: 1; mode=block

[

]
```

## DELETE /api/class_years/1
Destroys specified record.

### Example

#### Request
```
DELETE /api/class_years/1 HTTP/1.1
Accept: application/json
Access-Token: 55f9c2aa393639c4cc8b412e3f14b407fc99c9426329b67afc6a7884ae8b14f1
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
X-Request-Id: 4143022c-fa2d-487b-a76b-c716d89c35af
X-Runtime: 0.002381
X-XSS-Protection: 1; mode=block
```

## POST /api/class_years
Creates new class year.

### Example

#### Request
```
POST /api/class_years HTTP/1.1
Accept: application/json
Access-Token: 1a0f7041c2dbe0af5ac1eb7858a988c2500b56d6e91208c0eac1ab650bb2cf34
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
ETag: "a0df30c3c2203980d618d1d3c253006e"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: e1bea5f1-bf7e-4ce7-a71d-e4cc05e45a45
X-Runtime: 0.003133
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "year": 93,
  "created_at": "2014-09-19T21:56:48.321+09:00",
  "updated_at": "2014-09-19T21:56:48.321+09:00"
}
```
