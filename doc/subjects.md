## GET /api/subjects
Returns a list of subjects.

### Example

#### Request
```
GET /api/subjects HTTP/1.1
Accept: application/json
Access-Token: 5b5c4de474c93b9604fc873ebf18c38fde029a0c93206c72b3038e2c48aff15a
Content-Length: 0
Content-Type: application/json
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 163
Content-Type: application/json; charset=utf-8
ETag: W/"02f4cfde3b5034f5c3253561d6e3be84"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 06ec6d13-8861-4600-983a-231ec67b359e
X-Runtime: 0.005440
X-XSS-Protection: 1; mode=block

[
  {
    "id": 1,
    "title_ja": "生理学_1",
    "title_en": "physiology_1",
    "created_at": "2014-12-20T12:15:05.711+09:00",
    "updated_at": "2014-12-20T12:15:05.711+09:00",
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
Accept: application/json
Access-Token: 7daa621809344150ab047ba125dbc2e7edd3112b4b87ba3c32a62771cfbccf39
Content-Length: 0
Content-Type: application/json
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 161
Content-Type: application/json; charset=utf-8
ETag: W/"f200ba6bcd9b2db4c75eb33a9d742c3b"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 11f86271-745a-4033-9e49-17705d2efe68
X-Runtime: 0.003317
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "title_ja": "生理学_1",
  "title_en": "physiology_1",
  "created_at": "2014-12-20T12:15:05.711+09:00",
  "updated_at": "2014-12-20T12:15:05.711+09:00",
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
Accept: application/json
Access-Token: fd498388c1cd464ec3c70ad24bcadf78443b9dd1c87b3e8b26a370d239cff5b6
Content-Length: 48
Content-Type: application/json
Host: www.example.com

{
  "title_ja": "生理学",
  "title_en": "physiology"
}
```

#### Response
```
HTTP/1.1 201
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 157
Content-Type: application/json; charset=utf-8
ETag: W/"eea5819da0bd6d4e598805da053accb7"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: bab4aed0-962e-494a-bad4-a96335fc8089
X-Runtime: 0.005380
X-XSS-Protection: 1; mode=block

{
  "id": 4,
  "title_ja": "生理学",
  "title_en": "physiology",
  "created_at": "2014-12-20T12:15:06.130+09:00",
  "updated_at": "2014-12-20T12:15:06.130+09:00",
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
Accept: application/json
Access-Token: 011324a68722117ea575b7f72b1aedf57524c271f025db73a6869b9a854f6f68
Content-Length: 50
Content-Type: application/json
Host: www.example.com

{
  "title_ja": "生化学",
  "title_en": "biochemistry"
}
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 159
Content-Type: application/json; charset=utf-8
ETag: W/"17ef489c61c79b9004ec91549265f72c"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 8d7ebb17-c69f-4f83-a24f-468e69478321
X-Runtime: 0.005154
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "title_ja": "生化学",
  "title_en": "biochemistry",
  "created_at": "2014-12-20T12:15:05.711+09:00",
  "updated_at": "2014-12-20T12:15:06.519+09:00",
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
Accept: application/json
Access-Token: 724fbdd3ede4777629610f31caee0875d78c5d1d45e0c7bfd8b7760ecc24aa75
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
X-Request-Id: c4efc3ec-ba16-4e8b-afc9-acf0a54670b6
X-Runtime: 0.005135
X-XSS-Protection: 1; mode=block
```
