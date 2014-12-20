## GET /api/subjects
Returns a list of subjects.

### Example

#### Request
```
GET /api/subjects HTTP/1.1
Access-Token: 2fab4e9335e30cf0736d0cce495886aac7086f766d55793aea1feb76eebb38d2
```

#### Response
```
HTTP/1.1 200
Content-Type: application/json; charset=utf-8

[
  {
    "id": 1,
    "title_ja": "生理学_1",
    "title_en": "physiology_1",
    "created_at": "2014-01-01T00:00:00.000+09:00",
    "updated_at": "2014-01-01T00:00:00.000+09:00",
    "errors": {
    }
  }
]
```

## GET /api/subjects/1
Returns subject.

### Example

#### Request
```
GET /api/subjects/1 HTTP/1.1
Access-Token: e6780a60e18fc6b63d8b028bb331793ecc7f04df328ba7361addf9ba2408cf4d
```

#### Response
```
HTTP/1.1 200
Content-Type: application/json; charset=utf-8

{
  "id": 1,
  "title_ja": "生理学_1",
  "title_en": "physiology_1",
  "created_at": "2014-01-01T00:00:00.000+09:00",
  "updated_at": "2014-01-01T00:00:00.000+09:00",
  "errors": {
  }
}
```

## POST /api/subjects
Creates new subject.

### Example

#### Request
```
POST /api/subjects HTTP/1.1
Access-Token: 402a6279b03a642e5fdd1c4fb423826c04ef6f59f94d076f6710fb7e7aad3711

{
  "title_ja": "生理学",
  "title_en": "physiology"
}
```

#### Response
```
HTTP/1.1 201
Content-Type: application/json; charset=utf-8

{
  "id": 4,
  "title_ja": "生理学",
  "title_en": "physiology",
  "created_at": "2014-01-01T00:00:00.000+09:00",
  "updated_at": "2014-01-01T00:00:00.000+09:00",
  "errors": {
  }
}
```

## PATCH /api/subjects/1
Updates subject.

### Example

#### Request
```
PATCH /api/subjects/1 HTTP/1.1
Access-Token: c9184b76b28e7831415a2b44fb50fa7ff77bf45b0199223b565498c3c6433139

{
  "title_ja": "生化学",
  "title_en": "biochemistry"
}
```

#### Response
```
HTTP/1.1 200
Content-Type: application/json; charset=utf-8

{
  "id": 1,
  "title_ja": "生化学",
  "title_en": "biochemistry",
  "created_at": "2014-01-01T00:00:00.000+09:00",
  "updated_at": "2014-01-01T00:00:00.000+09:00",
  "errors": {
  }
}
```

## DELETE /api/subjects/1
Destroys specified record.

### Example

#### Request
```
DELETE /api/subjects/1 HTTP/1.1
Access-Token: d7a71148e060374974ba964cf642f3390945572b199a8357ce03e3144586e580
```

#### Response
```
HTTP/1.1 200
Content-Type: application/json
```
