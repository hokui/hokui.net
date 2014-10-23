## GET /api/semesters/1
Returns semester.

### Example

#### Request
```
GET /api/semesters/1 HTTP/1.1
Accept: application/json
Access-Token: 241b07ee1ec329f48d5f75b5243b6deb69614e36a5bd70b9087ff59e06440adb
Content-Length: 0
Content-Type: application/json
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 154
Content-Type: application/json; charset=utf-8
ETag: "2501e577ab3519aa45aa5917689809c2"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: bf05176e-09ae-4489-9f93-a0bd8b3e1332
X-Runtime: 0.003793
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "class_year_id": 1,
  "identifier": "2a",
  "subject_ids": [
    1,
    2
  ],
  "created_at": "2014-10-23T13:04:56.367+09:00",
  "updated_at": "2014-10-23T13:04:56.367+09:00"
}
```

## PATCH 
Updates semester.

### Example

#### Request
```
PATCH /api/semesters/1 HTTP/1.1
Accept: application/json
Access-Token: 7a9bdb19daf907662f8630b21bd0866bdef14b42e92f28673959c0693c3f6ac5
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
Content-Length: 154
Content-Type: application/json; charset=utf-8
ETag: "047de0ec5f7853598d011c2e1453aa3b"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: d34099a9-bb67-4071-9b56-69eb0f77b519
X-Runtime: 0.007708
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "class_year_id": 1,
  "identifier": "3a",
  "subject_ids": [
    2,
    3
  ],
  "created_at": "2014-10-23T13:04:56.690+09:00",
  "updated_at": "2014-10-23T13:04:56.839+09:00"
}
```

## GET /api/semesters
Returns a list of semesters.

### Example

#### Request
```
GET /api/semesters HTTP/1.1
Accept: application/json
Access-Token: 4dd103ac8e9fac40fa00e0f89fa50922b4268b85367ff7b494c7a75eef3f757c
Content-Length: 0
Content-Type: application/json
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 156
Content-Type: application/json; charset=utf-8
ETag: "8af034cceb72432cd0449516a6879067"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: eaf6c822-c1a1-4c90-b9ff-04dbda5d0c44
X-Runtime: 0.002749
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
    "created_at": "2014-10-23T13:04:56.864+09:00",
    "updated_at": "2014-10-23T13:04:56.864+09:00"
  }
]
```

## POST /api/semesters
Creates new semester.

### Example

#### Request
```
POST /api/semesters HTTP/1.1
Accept: application/json
Access-Token: ad15b4bb3d6f9c998f21867aadfb1256431c1e77b9ebf03b4846d94408d6a893
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
Content-Length: 154
Content-Type: application/json; charset=utf-8
ETag: "d32ac5f763cb579723d777dc43a3c5a6"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 5ee6da18-980a-4517-b354-a1bacd4fd0ef
X-Runtime: 0.008661
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "class_year_id": 1,
  "identifier": "2b",
  "subject_ids": [
    1,
    2
  ],
  "created_at": "2014-10-23T13:04:57.333+09:00",
  "updated_at": "2014-10-23T13:04:57.333+09:00"
}
```

## DELETE /api/semesters/1
Destroys specified record.

### Example

#### Request
```
DELETE /api/semesters/1 HTTP/1.1
Accept: application/json
Access-Token: 2ca18094465bafc2ea3b6732eadd112a997167f7f3629eabf557b27ed59c8805
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
X-Request-Id: a20a3600-afda-4d7f-9fc8-2676e358c52c
X-Runtime: 0.002824
X-XSS-Protection: 1; mode=block
```
