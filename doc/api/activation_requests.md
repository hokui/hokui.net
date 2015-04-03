## POST /api/activation_request
Delivers activation instruction.

### Example

#### Request
```
POST /api/activation_request HTTP/1.1


{"email":"guest@eis.hokudai.ac.jp"}
```

#### Response
```
HTTP/1.1 200
Content-Type: text/html
```

## POST /api/activation_request
Returns 400 if user is not found on db.

### Example

#### Request
```
POST /api/activation_request HTTP/1.1


{"email":"hoge@eis.hokudai.ac.jp"}
```

#### Response
```
HTTP/1.1 400
Content-Type: application/json; charset=utf-8

{
}
```

## POST /api/activation_request
Returns 400 if user is already activated.

### Example

#### Request
```
POST /api/activation_request HTTP/1.1


{"email":"guest@eis.hokudai.ac.jp"}
```

#### Response
```
HTTP/1.1 400
Content-Type: application/json; charset=utf-8

{
  "approval_state": "waiting"
}
```

## POST /api/activation_request
Returns 400 if user is already activated and approved.

### Example

#### Request
```
POST /api/activation_request HTTP/1.1


{"email":"guest@eis.hokudai.ac.jp"}
```

#### Response
```
HTTP/1.1 400
Content-Type: application/json; charset=utf-8

{
  "approval_state": "approved"
}
```
