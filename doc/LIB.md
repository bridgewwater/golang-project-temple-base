# github.com/stretchr/testify

[github.com/stretchr/testify](https://github.com/stretchr/testify)

```bash
go mod edit -require='github.com/stretchr/testify@v1.4.0'
go mod vendor
```

fast use

```go
import (
  "testing"
  "github.com/stretchr/testify/assert"
)

func TestSomething(t *testing.T) {

  // assert equality
  assert.Equal(t, 123, 123, "they should be equal")

  // assert inequality
  assert.NotEqual(t, 123, 456, "they should not be equal")

  // assert for nil (good for errors)
  assert.Nil(t, object)

  // assert for not nil (good when you expect something)
  if assert.NotNil(t, object) {

    // now we know that object isn't nil, we are safe to make
    // further assertions without causing any errors
    assert.Equal(t, "Something", object.Value)

  }
}
```

# github.com/smartystreets/goconvey

[github.com/smartystreets/goconvey](https://github.com/smartystreets/goconvey)

```bash
go mod edit -require='github.com/smartystreets/goconvey@v1.6.3'
go mod vendor
```