## GET /api/subjects/1/documents
Returns a list of documents.

### Example

#### Request
```
GET /api/subjects/1/documents HTTP/1.1
Access-Token: 0dcdeb801d73c2fae082efdcb355dfd199a5693ba0d400af3889a4b3ace9ea6a
```

#### Response
```
HTTP/1.1 200
Content-Type: application/json; charset=utf-8

[
  {
    "id": 15,
    "subject_id": 1,
    "class_year": 93,
    "code": 1,
    "created_at": "2014-01-01T00:00:00.000+09:00",
    "updated_at": "2014-01-01T00:00:00.000+09:00",
    "errors": {
    }
  },
  {
    "id": 8,
    "subject_id": 1,
    "class_year": 93,
    "code": 3,
    "created_at": "2014-01-01T00:00:00.000+09:00",
    "updated_at": "2014-01-01T00:00:00.000+09:00",
    "errors": {
    }
  },
  {
    "id": 16,
    "subject_id": 1,
    "class_year": 93,
    "code": 1099,
    "created_at": "2014-01-01T00:00:00.000+09:00",
    "updated_at": "2014-01-01T00:00:00.000+09:00",
    "errors": {
    }
  },
  {
    "id": 11,
    "subject_id": 1,
    "class_year": 93,
    "code": 3011,
    "created_at": "2014-01-01T00:00:00.000+09:00",
    "updated_at": "2014-01-01T00:00:00.000+09:00",
    "errors": {
    }
  },
  {
    "id": 12,
    "subject_id": 1,
    "class_year": 93,
    "code": 4002,
    "created_at": "2014-01-01T00:00:00.000+09:00",
    "updated_at": "2014-01-01T00:00:00.000+09:00",
    "errors": {
    }
  }
]
```

## GET /api/subjects/1/documents
Returns a list of documents with given range of code.

### Example

#### Request
```
GET /api/subjects/1/documents?code=0-1999 HTTP/1.1
Access-Token: 0dcdeb801d73c2fae082efdcb355dfd199a5693ba0d400af3889a4b3ace9ea6a
```

#### Response
```
HTTP/1.1 200
Content-Type: application/json; charset=utf-8

[
  {
    "id": 15,
    "subject_id": 1,
    "class_year": 93,
    "code": 1,
    "created_at": "2014-01-01T00:00:00.000+09:00",
    "updated_at": "2014-01-01T00:00:00.000+09:00",
    "errors": {
    }
  },
  {
    "id": 8,
    "subject_id": 1,
    "class_year": 93,
    "code": 3,
    "created_at": "2014-01-01T00:00:00.000+09:00",
    "updated_at": "2014-01-01T00:00:00.000+09:00",
    "errors": {
    }
  },
  {
    "id": 16,
    "subject_id": 1,
    "class_year": 93,
    "code": 1099,
    "created_at": "2014-01-01T00:00:00.000+09:00",
    "updated_at": "2014-01-01T00:00:00.000+09:00",
    "errors": {
    }
  }
]
```

## GET /api/subjects/1/documents/1
Returns a document.

### Example

#### Request
```
GET /api/subjects/2/documents/7 HTTP/1.1
Access-Token: 0dcdeb801d73c2fae082efdcb355dfd199a5693ba0d400af3889a4b3ace9ea6a
```

#### Response
```
HTTP/1.1 200
Content-Type: application/json; charset=utf-8

{
  "id": 7,
  "subject_id": 2,
  "class_year": 93,
  "code": 2001,
  "created_at": "2014-01-01T00:00:00.000+09:00",
  "updated_at": "2014-01-01T00:00:00.000+09:00",
  "errors": {
  }
}
```
