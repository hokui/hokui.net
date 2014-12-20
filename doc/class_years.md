## GET /api/class_years
Returns a list of class years, if ever client is unauthorized.

### Example

#### Request
```
GET /api/class_years HTTP/1.1

```

#### Response
```
HTTP/1.1 200
Content-Type: application/json; charset=utf-8

[
  {
    "id": 1,
    "year": 93,
    "created_at": "2014-01-01T00:00:00.000+09:00",
    "updated_at": "2014-01-01T00:00:00.000+09:00",
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

```

#### Response
```
HTTP/1.1 200
Content-Type: application/json; charset=utf-8

{
  "id": 1,
  "year": 93,
  "created_at": "2014-01-01T00:00:00.000+09:00",
  "updated_at": "2014-01-01T00:00:00.000+09:00",
  "errors": {
  }
}
```

## POST /api/class_years
Creates new class year.

### Example

#### Request
```
POST /api/class_years HTTP/1.1
Access-Token: 13059127b881760028e1a6aafa11a59de652b6910bde44c2f3c86564bdd36357

{
  "year": 94
}
```

#### Response
```
HTTP/1.1 201
Content-Type: application/json; charset=utf-8

{
  "id": 2,
  "year": 94,
  "created_at": "2014-01-01T00:00:00.000+09:00",
  "updated_at": "2014-01-01T00:00:00.000+09:00",
  "errors": {
  }
}
```

## PATCH /api/class_years/1
Updates class year.

### Example

#### Request
```
PATCH /api/class_years/1 HTTP/1.1
Access-Token: b0a042ff6a311ffbf4084feb9b4f4f0c686b0749988fa7529491cfe50bf6c16d

{
  "year": 94
}
```

#### Response
```
HTTP/1.1 200
Content-Type: application/json; charset=utf-8

{
  "id": 1,
  "year": 94,
  "created_at": "2014-01-01T00:00:00.000+09:00",
  "updated_at": "2014-01-01T00:00:00.000+09:00",
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
Access-Token: 675be01adc0353fb9ab58263a81161815c060616b886d1562ae6814f67b2bd2f
```

#### Response
```
HTTP/1.1 200
Content-Type: application/json
```
