## PATCH /api/class_years/1
Updates class year.

### Example

#### Request
```
PATCH /api/class_years/1 HTTP/1.1
Accept: application/json
Access-Token: ca9a485915e3eab7a110c0200b973d76b5735dc37e5f48921eb1a08a44b49f38
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
ETag: W/"22f4fd3c7ae2a981f09dca7ae45bf44d"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 964154f3-e2e0-4e1a-8b36-7d4d159d6b23
X-Runtime: 0.004622
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "year": 94,
  "created_at": "2014-12-13T21:52:54.179+09:00",
  "updated_at": "2014-12-13T21:52:54.467+09:00",
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
Access-Token: a6f8e56b08571b5704318e0539380a552d48121940ca7cef874665101b2b4851
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
X-Request-Id: fc1c6ae4-53b0-4bcf-a7ab-8a10a90d3a90
X-Runtime: 0.003115
X-XSS-Protection: 1; mode=block
```

## POST /api/class_years
Creates new class year.

### Example

#### Request
```
POST /api/class_years HTTP/1.1
Accept: application/json
Access-Token: 3655918fe3ce4f571d6297c500798dd87b4f58e1772705edc5e96fdb184622d1
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
ETag: W/"f32684fa5d1ff071a3ac45ea84241496"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 364bf062-8635-4bdb-9772-87501a78889e
X-Runtime: 0.004324
X-XSS-Protection: 1; mode=block

{
  "id": 2,
  "year": 94,
  "created_at": "2014-12-13T21:52:55.105+09:00",
  "updated_at": "2014-12-13T21:52:55.105+09:00",
  "errors": {
  }
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
Content-Length: 122
Content-Type: application/json; charset=utf-8
ETag: W/"26f70ce31c94e9a8272c2a7788db9972"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 6a2a91b0-84d9-4082-9810-58a8e6534ec5
X-Runtime: 0.001648
X-XSS-Protection: 1; mode=block

[
  {
    "id": 1,
    "year": 93,
    "created_at": "2014-12-13T21:52:54.179+09:00",
    "updated_at": "2014-12-13T21:52:54.179+09:00",
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
ETag: W/"9cc1d12241f4074ae93fd76e1f733d2f"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: e82d2d0b-efd2-4592-a444-d7c933ff99f9
X-Runtime: 0.001449
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "year": 93,
  "created_at": "2014-12-13T21:52:54.179+09:00",
  "updated_at": "2014-12-13T21:52:54.179+09:00",
  "errors": {
  }
}
```
