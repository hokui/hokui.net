## GET /api/semesters
Returns a list of semesters.

### Example

#### Request
```
GET /api/semesters HTTP/1.1
Access-Token: 0dcdeb801d73c2fae082efdcb355dfd199a5693ba0d400af3889a4b3ace9ea6a
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
Access-Token: 0dcdeb801d73c2fae082efdcb355dfd199a5693ba0d400af3889a4b3ace9ea6a
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
Access-Token: 0dcdeb801d73c2fae082efdcb355dfd199a5693ba0d400af3889a4b3ace9ea6a

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
Access-Token: 0dcdeb801d73c2fae082efdcb355dfd199a5693ba0d400af3889a4b3ace9ea6a

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
Access-Token: 0dcdeb801d73c2fae082efdcb355dfd199a5693ba0d400af3889a4b3ace9ea6a
```

#### Response
```
HTTP/1.1 200
Content-Type: application/json
```
