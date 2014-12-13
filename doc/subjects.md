## PATCH /api/subjects/1
Updates subject.

### Example

#### Request
```
PATCH /api/subjects/1 HTTP/1.1
Accept: application/json
Access-Token: bcf1cb81051c7172ab2c54c4a27fb5586b4ef8b985b53c7a664dab532a3beb63
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
ETag: W/"45314ed34ed2425dc6a866689b3273ac"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: f943b94a-d3a7-445d-b0c0-4165f1cef7ab
X-Runtime: 0.005139
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "title_ja": "生化学",
  "title_en": "biochemistry",
  "created_at": "2014-12-13T21:52:55.641+09:00",
  "updated_at": "2014-12-13T21:52:55.930+09:00",
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
Access-Token: 5fa67da3ee82a28d1b0c96ff4392f6717545b3962a89230bcfcc21ae3fb92e24
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
X-Request-Id: 4fab3437-3ee5-4fc2-9ead-cf70cc59ce1e
X-Runtime: 0.004858
X-XSS-Protection: 1; mode=block
```

## POST /api/subjects
Creates new subject.

### Example

#### Request
```
POST /api/subjects HTTP/1.1
Accept: application/json
Access-Token: 77175c321e8cb34388737c707955281818371a696a40ad90e7ef8518cb66954b
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
ETag: W/"6008f0329ab85b79c500e2d5f74e88b7"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 689edb06-c26a-4c0b-9427-5124b7a86edd
X-Runtime: 0.004736
X-XSS-Protection: 1; mode=block

{
  "id": 4,
  "title_ja": "生理学",
  "title_en": "physiology",
  "created_at": "2014-12-13T21:52:56.573+09:00",
  "updated_at": "2014-12-13T21:52:56.573+09:00",
  "errors": {
  }
}
```

## GET /api/subjects
Returns a list of subjects.

### Example

#### Request
```
GET /api/subjects HTTP/1.1
Accept: application/json
Access-Token: b58798c2823b82c1636810e7c0b7b7ee0ec7e4777079a50a9319191e74b8869e
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
ETag: W/"b1a6c565c1b718bb0ad2abfdf2abd85f"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 4af4d08f-66fe-4755-a163-ecda489c8c45
X-Runtime: 0.003169
X-XSS-Protection: 1; mode=block

[
  {
    "id": 1,
    "title_ja": "生理学_1",
    "title_en": "physiology_1",
    "created_at": "2014-12-13T21:52:55.641+09:00",
    "updated_at": "2014-12-13T21:52:55.641+09:00",
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
Access-Token: 59e830dafed3819917f3a0a30ffdfae8f8f9093f799127888d9d5f4e18c6da43
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
ETag: W/"b552bb5c20d0b820de4019e915200012"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 549f1340-7aca-4677-9529-a21bf455e645
X-Runtime: 0.003238
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "title_ja": "生理学_1",
  "title_en": "physiology_1",
  "created_at": "2014-12-13T21:52:55.641+09:00",
  "updated_at": "2014-12-13T21:52:55.641+09:00",
  "errors": {
  }
}
```
