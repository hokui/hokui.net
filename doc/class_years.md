## GET /api/class_years/1
Returns class year.

### Example

#### Request
```
GET /api/class_years/1 HTTP/1.1
Accept: application/json
Access-Token: 76850e278c289cda40cae7fe3aa91241cd0415b8e3f78cc05505beab632fce18
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
ETag: "e89edf752e96e96db4764f8dbcb00d36"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: f836f8d8-8002-4a4a-b410-760dc435cfa0
X-Runtime: 0.002696
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "year": 93,
  "created_at": "2014-10-23T13:04:57.664+09:00",
  "updated_at": "2014-10-23T13:04:57.664+09:00"
}
```

## PATCH 
Updates class year.

### Example

#### Request
```
PATCH /api/class_years/1 HTTP/1.1
Accept: application/json
Access-Token: fcc4202ba58a6284f7bd20b55702c0467dcebc06165914672540e98aad363c2a
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
Content-Length: 108
Content-Type: application/json; charset=utf-8
ETag: "b03a5b7e11f5602a15cfd312554c0867"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 5ca79cca-2166-4f8e-9829-401ba999e905
X-Runtime: 0.005317
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "year": 94,
  "created_at": "2014-10-23T13:04:57.965+09:00",
  "updated_at": "2014-10-23T13:04:58.112+09:00"
}
```

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
Content-Length: 110
Content-Type: application/json; charset=utf-8
ETag: "1652458b89d498ba2237483c83bcd91d"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 5f2cf314-ff10-459c-a6d6-69ce0bc196b6
X-Runtime: 0.001742
X-XSS-Protection: 1; mode=block

[
  {
    "id": 1,
    "year": 93,
    "created_at": "2014-10-23T13:04:58.116+09:00",
    "updated_at": "2014-10-23T13:04:58.116+09:00"
  }
]
```

## POST /api/class_years
Creates new class year.

### Example

#### Request
```
POST /api/class_years HTTP/1.1
Accept: application/json
Access-Token: 398daa14ccc9ca4c29af5b0303b79482edff87bee8813f48444dee1ee1fda10b
Content-Length: 11
Content-Type: application/json
Host: www.example.com

{
  "year": 93
}
```

#### Response
```
HTTP/1.1 201
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 108
Content-Type: application/json; charset=utf-8
ETag: "16e549cf7ed7510f8401ed0bad53b602"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: b6a67175-3123-46a2-8e94-775109e05012
X-Runtime: 0.003589
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "year": 93,
  "created_at": "2014-10-23T13:04:58.412+09:00",
  "updated_at": "2014-10-23T13:04:58.412+09:00"
}
```

## DELETE /api/class_years/1
Destroys specified record.

### Example

#### Request
```
DELETE /api/class_years/1 HTTP/1.1
Accept: application/json
Access-Token: 7161c64afde9baa05c90584f9ec90d41f18aa47cc87065cec7ab81098b0f1d2e
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
X-Request-Id: a09b0ac7-4786-48de-ac12-ab9c8d9577b6
X-Runtime: 0.002424
X-XSS-Protection: 1; mode=block
```
