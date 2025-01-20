package cmd

import (
	"fmt"
	"log/slog"
	"math/rand/v2"
	"os"
	"os/exec"

	"github.com/spf13/cobra"
	"github.com/spf13/viper"

	"github.com/mattjmcnaughton/toolbox-vim/internal/logging"
)

// runCmd represents the run command
var runCmd = &cobra.Command{
	Use:   "run",
	Short: "Run toolbox-vim!",
	Long:  `Run a containerized vim based on the configuration values.`,
	RunE: func(cmd *cobra.Command, args []string) error {
		return runCmdRun(cmd, args, logging.NewCmdLogger("run"))
	},
	SilenceUsage:  true,
	SilenceErrors: true,
}

func init() {
	rootCmd.AddCommand(runCmd)
}

func runCmdRun(_ *cobra.Command, _ []string, logger *slog.Logger) error {
	containerRepo := viper.GetString("container-repo")
	containerTag := viper.GetString("container-tag")

	missingContainerConfig := containerRepo == "" || containerTag == ""
	if missingContainerConfig {
		return fmt.Errorf(
			"missing required container config values: container-repo=%s, container-tag=%s",
			containerRepo,
			containerTag,
		)
	}

	var volumeMountArgs []string
	var workingDir string

	filesystemMount := viper.GetString("filesystem-mount")
	switch filesystemMount {
	case "cwd":
		cwdPath, err := os.Getwd()
		if err != nil {
			return fmt.Errorf("failed determining cwd: %w", err)
		}

		volumeMountArgs = []string{"-v", fmt.Sprintf("%s:%s", cwdPath, cwdPath)}
		workingDir = cwdPath
	default:
		return fmt.Errorf(
			"invalid filesystemMount value: filesystem-mount=%s",
			filesystemMount,
		)
	}

	environmentVariables := viper.GetStringSlice("environment-variables")
	environmentVariableArgs := make([]string, len(environmentVariables)*2)

	for i, envVar := range environmentVariables {
		environmentVariableArgs[i*2] = "-e"
		environmentVariableArgs[i*2+1] = envVar
	}

	containerImage := fmt.Sprintf("%s:%s", containerRepo, containerTag)
	containerName := generateUniqueContainerName()

	dockerRunArgs := append(
		append(
			append(
				[]string{
					"run",
					"-it",
					"-w", workingDir,
				},
				environmentVariableArgs...,
			),
			volumeMountArgs...,
		),
		[]string{
			"--name", containerName,
			containerImage,
			"/bin/bash",
		}...,
	)

	logger.Debug(
		"command-args",
		slog.Any("docker-run-args", dockerRunArgs),
	)

	execCmd := exec.Command("docker", dockerRunArgs...)

	execCmd.Stdin = os.Stdin
	execCmd.Stdout = os.Stdout

	if err := execCmd.Run(); err != nil {
		return fmt.Errorf("running containerized toolbox-vim (via exec.Command().Run()) failed: %w", err)
	}

	return nil
}

func generateUniqueContainerName() string {
	return fmt.Sprintf("toolbox-vim-%d", rand.IntN(1000))
}
