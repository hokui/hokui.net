## PATCH /api/semesters/1
Updates semester.

### Example

#### Request
```
PATCH /api/semesters/1 HTTP/1.1
Accept: application/json
Access-Token: 7fc59cc5ba02c74e8f6a95c3f0f35e8234600db47d884a2cdbfa4aedbbb599c4
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
ETag: W/"03706ca401f22e6a2ad51998412f6969"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: c6af7ef5-e980-4703-9d96-97962839177d
X-Runtime: 0.007404
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "class_year_id": 1,
  "identifier": "3a",
  "subject_ids": [
    2,
    3
  ],
  "created_at": "2014-12-13T21:52:52.734+09:00",
  "updated_at": "2014-12-13T21:52:53.084+09:00",
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
Access-Token: f98195d36c41e8cfa48765077512062c1085e24e9733d94338e783e8f13b66c9
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
X-Request-Id: 788382c2-6c6f-4895-a7c4-05a1f1c2be16
X-Runtime: 0.003500
X-XSS-Protection: 1; mode=block
```

## POST /api/semesters
Creates new semester.

### Example

#### Request
```
POST /api/semesters HTTP/1.1
Accept: application/json
Access-Token: 016e3e71a59c412390b5d470014b3638cc807d1eb605235627bb2cfc8de63826
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
ETag: W/"dc79043b625e18c65023bea727c73eb6"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 052edddb-9430-4300-8051-9e476c67170f
X-Runtime: 0.009810
X-XSS-Protection: 1; mode=block

{
  "id": 2,
  "class_year_id": 1,
  "identifier": "2b",
  "subject_ids": [
    1,
    2
  ],
  "created_at": "2014-12-13T21:52:53.730+09:00",
  "updated_at": "2014-12-13T21:52:53.730+09:00",
  "errors": {
  }
}
```

## GET /api/semesters
Returns a list of semesters.

### Example

#### Request
```
GET /api/semesters HTTP/1.1
Accept: application/json
Access-Token: 189bac9c547ffc67fda45d9839ad4ea456d8752f6636bba33c5fc70802ea5543
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
ETag: W/"d30aa16a09fea2b9130f59bbd4b3f621"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: e53ef7f2-bf8a-48cc-a26d-aea1d22fa221
X-Runtime: 0.003630
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
    "created_at": "2014-12-13T21:52:52.734+09:00",
    "updated_at": "2014-12-13T21:52:52.734+09:00",
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
Access-Token: 6c33ffb484ea1e4c3bcea3e48175d76ff1a16770c23a182d0994f15da39cd43d
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
ETag: W/"26b13984de819e2938fe6d6a47f0e685"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: c7003157-bdcd-4aab-b3e7-6003d29a6853
X-Runtime: 0.003571
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "class_year_id": 1,
  "identifier": "2a",
  "subject_ids": [
    1,
    2
  ],
  "created_at": "2014-12-13T21:52:52.734+09:00",
  "updated_at": "2014-12-13T21:52:52.734+09:00",
  "errors": {
  }
}
```
