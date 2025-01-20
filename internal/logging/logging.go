package logging

import (
	"fmt"
	"log/slog"
	"os"
	"strings"

	"github.com/mattjmcnaughton/toolbox-vim/internal/constants"
)

const defaultLogLevel = slog.LevelInfo

// In `logging.go`, we retreive config values directly from environment variables.
// We wish for this package to have _no_ dependencies (not even `internal/config`).

func NewRootLogger() *slog.Logger {
	opts := &slog.HandlerOptions{
		AddSource: true,
		Level:     getLogLevel(),
	}

	envEnvKey := fmt.Sprintf("%s_ENV", constants.EnvVariablePrefix)
	env, _ := os.LookupEnv(envEnvKey)

	var logger *slog.Logger
	if env == "prod" {
		logger = slog.New(slog.NewJSONHandler(os.Stdout, opts))
	} else {
		logger = slog.New(slog.NewTextHandler(os.Stdout, opts))
	}

	return logger
}

func getLogLevel() slog.Level {
	logLevelEnvKey := fmt.Sprintf("%s_LOG_LEVEL", constants.EnvVariablePrefix)
	logLevel, _ := os.LookupEnv(logLevelEnvKey)

	switch strings.ToUpper(logLevel) {
	case "DEBUG":
		return slog.LevelDebug
	case "INFO":
		return slog.LevelInfo
	case "WARN":
		return slog.LevelWarn
	case "ERROR":
		return slog.LevelError
	default:
		return defaultLogLevel
	}
}

func NewCmdLogger(cmd string) *slog.Logger {
	logger := NewRootLogger()

	cmdLogger := logger.With(
		slog.String("cmd", cmd),
	)

	return cmdLogger
}
