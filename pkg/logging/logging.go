package logging

import (
	"log/slog"
	"os"
)

func NewRoot() *slog.Logger {
	opts := &slog.HandlerOptions{
		Level: slog.LevelDebug,
	}
	logger := slog.New(slog.NewJSONHandler(os.Stdout, opts))

	return logger
}

func NewCmd(cmd string) *slog.Logger {
	logger := NewRoot()

	cmdLogger := logger.With(
		slog.String("cmd", cmd),
	)

	return cmdLogger
}
