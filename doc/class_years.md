## DELETE /api/class_years/1
Destroys specified record.

### Example

#### Request
```
DELETE /api/class_years/1 HTTP/1.1
Accept: application/json
Access-Token: b65f3688ffcfce474f59e74eb55fff6109c4fbb987b4496e60cd553dd7682ae2
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
X-Request-Id: 245d1dd0-db4a-4a2b-8fbc-0c8dec32c2c7
X-Runtime: 0.010200
X-XSS-Protection: 1; mode=block
```

## POST /api/class_years
Creates new class year.

### Example

#### Request
```
POST /api/class_years HTTP/1.1
Accept: application/json
Access-Token: 48011a180cd1797a9fde700fd6dd679c6b66b0ea438189025d785bb8f180212c
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
ETag: "abc7cfbadffa3d5c85eefc552af31686"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 5966890c-d488-438a-8c98-637a7f02ff2b
X-Runtime: 0.020478
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "year": 93,
  "created_at": "2014-09-23T22:46:25.435+09:00",
  "updated_at": "2014-09-23T22:46:25.435+09:00"
}
```

## GET /api/class_years/1
Returns class year.

### Example

#### Request
```
GET /api/class_years/1 HTTP/1.1
Accept: application/json
Access-Token: 294b013c73bc07673b98938fc1a8a18dc640b46d57d7e7a765ce45d6b84db434
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
ETag: "bcd58321e3f178b7d0aaef4e4c9ebc58"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 97564023-52c8-4115-85fc-5c396f227cae
X-Runtime: 0.003878
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "year": 93,
  "created_at": "2014-09-23T22:46:25.680+09:00",
  "updated_at": "2014-09-23T22:46:25.680+09:00"
}
```

## GET /api/class_years
Returns a list of class years.

### Example

#### Request
```
GET /api/class_years HTTP/1.1
Accept: application/json
Access-Token: 8afa6c7da529215bc2c93705164b073f6220e10bdbc885b301da444dcc27d998
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
X-Request-Id: ef738593-9996-49c9-a066-7b2cf9681758
X-Runtime: 0.003315
X-XSS-Protection: 1; mode=block

[

]
```

## PATCH 
Updates class year.

### Example

#### Request
```
PATCH /api/class_years/1 HTTP/1.1
Accept: application/json
Access-Token: 5fd4c1fb230566b2ad09b5699418b3bc966abf896f3df5cb86c748b22afd12ac
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
X-Request-Id: 3df56333-1b80-42ed-af80-ce78f12d714f
X-Runtime: 0.005311
X-XSS-Protection: 1; mode=block
```
