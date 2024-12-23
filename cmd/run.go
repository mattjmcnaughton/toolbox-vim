package cmd

import (
	"fmt"
	"log"
	"log/slog"
	"math/rand/v2"
	"os"
	"os/exec"

	"github.com/spf13/cobra"
	"github.com/spf13/viper"
)

// runCmd represents the run command
var runCmd = &cobra.Command{
	Use:   "run",
	Short: "Run toolbox-vim!",
	Long:  `Run a containerized vim based on the configuration values.`,
	Run:   runCmdRun,
}

func init() {
	rootCmd.AddCommand(runCmd)
}

func runCmdRun(_ *cobra.Command, _ []string) {
	containerRepo := viper.GetString("container-repo")
	containerTag := viper.GetString("container-tag")

	missingContainerConfig := containerRepo == "" || containerTag == ""
	if missingContainerConfig {
		slog.Info(
			"Missing container config",
			"container-repo", containerRepo,
			"container-tag", containerTag,
		)
		// TODO: Come up w/ a better logging strategy.
		log.Fatalf("Missing container config")
	}

	var volumeMountArgs []string
	var workingDir string

	filesystemMount := viper.GetString("filesystem-mount")
	switch filesystemMount {
	case "cwd":
		cwdPath, err := os.Getwd()
		if err != nil {
			log.Fatal(err)
		}

		volumeMountArgs = []string{"-v", fmt.Sprintf("%s:%s", cwdPath, cwdPath)}
		workingDir = cwdPath
	default:
		log.Fatalf("Invalid filesystemMount value:%s", filesystemMount)
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

	slog.Info(
		"command-args",
		"docker-run-args", dockerRunArgs,
	)

	execCmd := exec.Command("docker", dockerRunArgs...)

	execCmd.Stdin = os.Stdin
	execCmd.Stdout = os.Stdout

	// TODO: How to do error handling in sub-commands...
	if err := execCmd.Run(); err != nil {
		log.Fatalf("%s", err)
	}
}

func generateUniqueContainerName() string {
	return fmt.Sprintf("toolbox-vim-%d", rand.IntN(1000))
}
