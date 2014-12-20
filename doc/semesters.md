## GET /api/semesters
Returns a list of semesters.

### Example

#### Request
```
GET /api/semesters HTTP/1.1
Accept: application/json
Access-Token: 12cdb8f8c291a915d24ff053eccfb61daab2ce3703f452bc5103a11b2c2ff4b0
Content-Length: 0
Content-Type: application/json
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 168
Content-Type: application/json; charset=utf-8
ETag: W/"4d80f30816d57004fb247cb8741a3bd9"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 3655ca91-1505-489a-a6a6-5ddb1b079956
X-Runtime: 0.006513
X-XSS-Protection: 1; mode=block

[
  {
    "id": 1,
    "class_year_id": 1,
    "identifier": "2a",
    "subject_ids": [
      1,
      2
    ],
    "created_at": "2014-12-20T12:15:03.611+09:00",
    "updated_at": "2014-12-20T12:15:03.611+09:00",
    "errors": {
    }
  }
]
```

## GET /api/semesters/1
Returns semester.

### Example

#### Request
```
GET /api/semesters/1 HTTP/1.1
Accept: application/json
Access-Token: 703b02a594f18b9e182f1eb81e1276369a3bb2eaa23b8c6fe934376ec47cae70
Content-Length: 0
Content-Type: application/json
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 166
Content-Type: application/json; charset=utf-8
ETag: W/"c5985a859bcd600de12e7534723eb229"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 1012d30c-d3ea-47bf-8288-482bfac51eac
X-Runtime: 0.003919
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "class_year_id": 1,
  "identifier": "2a",
  "subject_ids": [
    1,
    2
  ],
  "created_at": "2014-12-20T12:15:03.611+09:00",
  "updated_at": "2014-12-20T12:15:03.611+09:00",
  "errors": {
  }
}
```

## POST /api/semesters
Creates new semester.

### Example

#### Request
```
POST /api/semesters HTTP/1.1
Accept: application/json
Access-Token: fe0e5a1f3971d2fcf79ff528fa09a08b8b7d3373def336f37a24618d35f8c8e1
Content-Length: 57
Content-Type: application/json
Host: www.example.com

{
  "class_year_id": 1,
  "identifier": "2b",
  "subject_ids": [
    1,
    2
  ]
}
```

#### Response
```
HTTP/1.1 201
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 166
Content-Type: application/json; charset=utf-8
ETag: W/"17f616f4b52c64b84ca31857cb80fd94"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 3cbc5a3b-c1c0-4c51-89ca-347df87b0992
X-Runtime: 0.012192
X-XSS-Protection: 1; mode=block

{
  "id": 2,
  "class_year_id": 1,
  "identifier": "2b",
  "subject_ids": [
    1,
    2
  ],
  "created_at": "2014-12-20T12:15:04.059+09:00",
  "updated_at": "2014-12-20T12:15:04.059+09:00",
  "errors": {
  }
}
```

## PATCH /api/semesters/1
Updates semester.

### Example

#### Request
```
PATCH /api/semesters/1 HTTP/1.1
Accept: application/json
Access-Token: 570f50f770e89bc5849361c8ad8fa8e1b760de06d4cb7a29530892097bc32260
Content-Length: 57
Content-Type: application/json
Host: www.example.com

{
  "class_year_id": 1,
  "identifier": "3a",
  "subject_ids": [
    2,
    3
  ]
}
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 166
Content-Type: application/json; charset=utf-8
ETag: W/"95fef4d006c793635be91e5e6c77c33d"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 8c8630dc-535a-46d7-bd05-73a0d2c59bfd
X-Runtime: 0.007346
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "class_year_id": 1,
  "identifier": "3a",
  "subject_ids": [
    2,
    3
  ],
  "created_at": "2014-12-20T12:15:03.611+09:00",
  "updated_at": "2014-12-20T12:15:04.453+09:00",
  "errors": {
  }
}
```

## DELETE /api/semesters/1
Destroys specified record.

### Example

#### Request
```
DELETE /api/semesters/1 HTTP/1.1
Accept: application/json
Access-Token: 4375a9b7bb204b37e9db9a27255c62cd0ceb8b17d6b960e3adc3cc70781aa2c5
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
X-Request-Id: f643b8bc-f6c4-4101-926f-a75e430cd0d9
X-Runtime: 0.003688
X-XSS-Protection: 1; mode=block
```
