## GET /api/class_years
Returns a list of class years.

### Example

#### Request
```
GET /api/class_years HTTP/1.1
Accept: application/json
Access-Token: 1ead9a4a15ec5ace3ec9715ec91ba8d7bf71f0cf040197300a20678bbdd9e1e6
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
X-Request-Id: 9ca96aa7-ec2b-49dd-9f86-58ac003b5a14
X-Runtime: 0.007528
X-XSS-Protection: 1; mode=block

[

]
```

## POST /api/class_years
Creates new class year.

### Example

#### Request
```
POST /api/class_years HTTP/1.1
Accept: application/json
Access-Token: 6fb6354a48207362cc6c11b9740c41f88d8811889e5f530e6ff9d6f16d2f69b3
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
ETag: "11c5c7fd4090cc67ffc361fe001e7424"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 0794b03e-a88a-4799-b8c5-28f3ba6f2717
X-Runtime: 0.012494
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "year": 93,
  "created_at": "2014-09-22T11:31:57.140+09:00",
  "updated_at": "2014-09-22T11:31:57.140+09:00"
}
```

## DELETE /api/class_years/1
Destroys specified record.

### Example

#### Request
```
DELETE /api/class_years/1 HTTP/1.1
Accept: application/json
Access-Token: 161f6714c0fe8abee2ba880dd0cfefca4bb274a728f4b6958031874f0fdd9d56
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
X-Request-Id: 83802471-6116-4184-8d82-17d1434adcd6
X-Runtime: 0.006581
X-XSS-Protection: 1; mode=block
```

## GET /api/class_years/1
Returns class year.

### Example

#### Request
```
GET /api/class_years/1 HTTP/1.1
Accept: application/json
Access-Token: e504ffd2c7be1b054d0780e1bfdbd7c354f8f092af40a7ec7247fc1c206db337
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
ETag: "5fa0e0a2795c6a4b949391d21b5ce800"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 747765f0-0840-4c9f-ae21-85af4be24b80
X-Runtime: 0.005729
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "year": 93,
  "created_at": "2014-09-22T11:31:57.713+09:00",
  "updated_at": "2014-09-22T11:31:57.713+09:00"
}
```

## PATCH 
Updates class year.

### Example

#### Request
```
PATCH /api/class_years/1 HTTP/1.1
Accept: application/json
Access-Token: 2560f8c14e6e5b715fc49e04c47e15c08e6057cdf2b63eccd679ec9ccec62151
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
X-Request-Id: cfc8001b-1041-4f4d-8795-485faaad19d7
X-Runtime: 0.008431
X-XSS-Protection: 1; mode=block
```
