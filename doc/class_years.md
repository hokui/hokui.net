## GET /api/class_years
Returns a list of class years, if ever client is unauthorized.

### Example

#### Request
```
GET /api/class_years HTTP/1.1
Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
Content-Length: 0
Content-Type: application/x-www-form-urlencoded
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 122
Content-Type: application/json; charset=utf-8
ETag: W/"20c2cff3d303a43ef59ce6a64e6185d6"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: d4e9b7a8-7f3d-4f0e-ac92-f3c2a01e9380
X-Runtime: 0.006228
X-XSS-Protection: 1; mode=block

[
  {
    "id": 1,
    "year": 93,
    "created_at": "2014-12-20T12:14:59.514+09:00",
    "updated_at": "2014-12-20T12:14:59.514+09:00",
    "errors": {
    }
  }
]
```

## GET /api/class_years/1
Returns a class year, if ever client is unauthorized.

### Example

#### Request
```
GET /api/class_years/1 HTTP/1.1
Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
Content-Length: 0
Content-Type: application/x-www-form-urlencoded
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 120
Content-Type: application/json; charset=utf-8
ETag: W/"245cbfe3bcd60a9a97b54decc91ecd4d"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 29e678d9-ab4a-437c-b82c-939cff6a33e0
X-Runtime: 0.001943
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "year": 93,
  "created_at": "2014-12-20T12:14:59.514+09:00",
  "updated_at": "2014-12-20T12:14:59.514+09:00",
  "errors": {
  }
}
```

## POST /api/class_years
Creates new class year.

### Example

#### Request
```
POST /api/class_years HTTP/1.1
Accept: application/json
Access-Token: 5c764a82e2bbd41a966d68761a2d472938a6cbb9926ee66f802b448effb5489e
Content-Length: 11
Content-Type: application/json
Host: www.example.com

{
  "year": 94
}
```

#### Response
```
HTTP/1.1 201
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 120
Content-Type: application/json; charset=utf-8
ETag: W/"f61dbe2e9ed0bbcb7de45a2a73e229f2"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 91014aaa-cc1d-49ce-a929-0017ca3ee761
X-Runtime: 0.006095
X-XSS-Protection: 1; mode=block

{
  "id": 2,
  "year": 94,
  "created_at": "2014-12-20T12:14:59.674+09:00",
  "updated_at": "2014-12-20T12:14:59.674+09:00",
  "errors": {
  }
}
```

## PATCH /api/class_years/1
Updates class year.

### Example

#### Request
```
PATCH /api/class_years/1 HTTP/1.1
Accept: application/json
Access-Token: 88d3a38f873e5edabad1525bf9a63f75c785477bdd6bc46c15f3c59995750120
Content-Length: 11
Content-Type: application/json
Host: www.example.com

{
  "year": 94
}
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 120
Content-Type: application/json; charset=utf-8
ETag: W/"54752ae78a4fec82b6486ce418dae605"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 19307818-161d-4bdf-a587-ae5d7f0a5892
X-Runtime: 0.004753
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "year": 94,
  "created_at": "2014-12-20T12:14:59.514+09:00",
  "updated_at": "2014-12-20T12:15:00.065+09:00",
  "errors": {
  }
}
```

## DELETE /api/class_years/1
Destroys specified record.

### Example

#### Request
```
DELETE /api/class_years/1 HTTP/1.1
Accept: application/json
Access-Token: 6a5eb105bccd2cc76eaedc3979805d83275c016d89a7a8ffcd4f43f6c959c00e
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
X-Request-Id: e8550511-a855-4e52-887e-bc13a3ec43f9
X-Runtime: 0.003868
X-XSS-Protection: 1; mode=block
```
