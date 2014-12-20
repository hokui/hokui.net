## GET /api/semesters
Returns a list of semesters.

### Example

#### Request
```
GET /api/semesters HTTP/1.1
Access-Token: 93d69586e00e7f7d8db030b287e3ab349d897218214f92035c7db2cd0a615836
```

#### Response
```
HTTP/1.1 200
Content-Type: application/json; charset=utf-8

[
  {
    "id": 1,
    "class_year_id": 1,
    "identifier": "2a",
    "subject_ids": [
      1,
      2
    ],
    "created_at": "2014-01-01T00:00:00.000+09:00",
    "updated_at": "2014-01-01T00:00:00.000+09:00",
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
Access-Token: fa71872492ea6ce452a3f52a0f38cfb2c3f8fe01f1de3ffbc866a89343d1656e
```

#### Response
```
HTTP/1.1 200
Content-Type: application/json; charset=utf-8

{
  "id": 1,
  "class_year_id": 1,
  "identifier": "2a",
  "subject_ids": [
    1,
    2
  ],
  "created_at": "2014-01-01T00:00:00.000+09:00",
  "updated_at": "2014-01-01T00:00:00.000+09:00",
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
Access-Token: 741da5ca33dfd1447b5461619a6de81cacd81fa84584fc79de66c01dc12c02e8

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
Content-Type: application/json; charset=utf-8

{
  "id": 2,
  "class_year_id": 1,
  "identifier": "2b",
  "subject_ids": [
    1,
    2
  ],
  "created_at": "2014-01-01T00:00:00.000+09:00",
  "updated_at": "2014-01-01T00:00:00.000+09:00",
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
Access-Token: 9a99d07b59a9eec7efa434ab0ad962afb070e3c174018f5387e1ecf94942a483

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
Content-Type: application/json; charset=utf-8

{
  "id": 1,
  "class_year_id": 1,
  "identifier": "3a",
  "subject_ids": [
    2,
    3
  ],
  "created_at": "2014-01-01T00:00:00.000+09:00",
  "updated_at": "2014-01-01T00:00:00.000+09:00",
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
Access-Token: 885094fd5c91666173db22848075afdd8715df9af5d66a395afcb6cb9afdbb89
```

#### Response
```
HTTP/1.1 200
Content-Type: application/json
```
