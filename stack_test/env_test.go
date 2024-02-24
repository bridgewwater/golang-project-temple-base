package stack_test

import (
	"github.com/sinlov-go/unittest-kit/env_kit"
	"github.com/sinlov-go/unittest-kit/unittest_env_kit"
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestEnvKeys(t *testing.T) {
	// mock EnvKeys
	const keyEnvs = "ENV_KEYS"
	t.Logf("~> mock EnvKeys")

	unittest_env_kit.SetEnvBool(t, keyEnvDebug, true)

	unittest_env_kit.SetEnvInt64(t, keyEnvCiNum, 2)

	unittest_env_kit.SetEnvStr(t, keyEnvCiKey, "foo")

	// do EnvKeys
	t.Logf("~> do EnvKeys")

	// verify EnvKeys

	assert.True(t, env_kit.FetchOsEnvBool(keyEnvDebug, false))
	assert.Equal(t, 2, env_kit.FetchOsEnvInt(keyEnvCiNum, 0))
	assert.Equal(t, "foo", env_kit.FetchOsEnvStr(keyEnvCiKey, ""))
	envArray := env_kit.FetchOsEnvArray(keyEnvs)
	assert.Nil(t, envArray)

	unittest_env_kit.SetEnvStr(t, keyEnvs, "foo, bar,My ")

	envArray = env_kit.FetchOsEnvArray(keyEnvs)

	assert.NotNil(t, envArray)
	assert.Equal(t, "foo", envArray[0])
	assert.Equal(t, "bar", envArray[1])
	assert.Equal(t, "My", envArray[2])

	t.Logf("~> verify EnvKeys: \n%s", env_kit.FindAllEnvByPrefix4Print("CI_"))
	envByPrefix := env_kit.FindAllEnvByPrefix("CI_")
	t.Logf("~> print findAllEnvByPrefix: %v", envByPrefix)
}
