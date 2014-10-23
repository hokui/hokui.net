## GET /api/subjects/1
Returns subject.

### Example

#### Request
```
GET /api/subjects/1 HTTP/1.1
Accept: application/json
Access-Token: 71f54f3f13694e8132d89799da19071fe1f885ec0a2be064074006c2f9d8d266
Content-Length: 0
Content-Type: application/json
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 149
Content-Type: application/json; charset=utf-8
ETag: "12b2c59450be13cb745e8b89e17e6fc8"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 80fb53b3-9763-43f6-a4e3-b6a141f734e8
X-Runtime: 0.004495
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "title_ja": "生理学_2",
  "title_en": "physiology_2",
  "created_at": "2014-10-23T13:04:58.720+09:00",
  "updated_at": "2014-10-23T13:04:58.720+09:00"
}
```

## PATCH 
Updates subject.

### Example

#### Request
```
PATCH /api/subjects/1 HTTP/1.1
Accept: application/json
Access-Token: 0dcdeb801d73c2fae082efdcb355dfd199a5693ba0d400af3889a4b3ace9ea6a
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
Content-Length: 147
Content-Type: application/json; charset=utf-8
ETag: "7b10ef361e4a119d800676ad978924ff"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 551b9649-bafc-4996-bbbd-5b58e5251f68
X-Runtime: 0.004380
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "title_ja": "生化学",
  "title_en": "biochemistry",
  "created_at": "2014-10-23T13:04:59.024+09:00",
  "updated_at": "2014-10-23T13:04:59.172+09:00"
}
```

## GET /api/subjects
Returns a list of subjects.

### Example

#### Request
```
GET /api/subjects HTTP/1.1
Accept: application/json
Access-Token: 5c5a05f6496dc5da0c6a457dbb0e326c6a32103315ce02375c2ba9d40e4f90e4
Content-Length: 0
Content-Type: application/json
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 151
Content-Type: application/json; charset=utf-8
ETag: "196de0d934eb117c5a590eb6efbe8632"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 767ba203-ae4f-4ff9-b76a-4066fdcf18b5
X-Runtime: 0.002539
X-XSS-Protection: 1; mode=block

[
  {
    "id": 1,
    "title_ja": "生理学_7",
    "title_en": "physiology_7",
    "created_at": "2014-10-23T13:04:59.180+09:00",
    "updated_at": "2014-10-23T13:04:59.180+09:00"
  }
]
```

## POST /api/subjects
Creates new subject.

### Example

#### Request
```
POST /api/subjects HTTP/1.1
Accept: application/json
Access-Token: 55df79d6933fa7565bdefe0f55d6adf44f4a8cbe6af3cd904d8c4882d1bf3c41
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
Content-Length: 145
Content-Type: application/json; charset=utf-8
ETag: "4fcbb964c6bac020fcc78014c3e35f91"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: da070bc8-27c6-45e6-b2f7-6fdb27fbbe33
X-Runtime: 0.003843
X-XSS-Protection: 1; mode=block

{
  "id": 1,
  "title_ja": "生理学",
  "title_en": "physiology",
  "created_at": "2014-10-23T13:04:59.618+09:00",
  "updated_at": "2014-10-23T13:04:59.618+09:00"
}
```

## DELETE /api/subjects/1
Destroys specified record.

### Example

#### Request
```
DELETE /api/subjects/1 HTTP/1.1
Accept: application/json
Access-Token: 70cdd880c2bbdd897a934de7ff301575ff234abe95ca97912538bbf0c73a19eb
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
X-Request-Id: 2463621a-63c3-417e-8b6a-16643fb4306c
X-Runtime: 0.004208
X-XSS-Protection: 1; mode=block
```
