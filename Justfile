# === Global ===

binary_name := "toolbox-vim"

# === Developer commands ===

set positional-arguments

install:
  pre-commit install
  go mod download
  go mod verify

clean:
  rm {{binary_name}} || true

fmt:
  # Runs `gofmt -l -w` on the named packages under the hood.
  go fmt ./...

vet:
  go vet ./...

tidy:
  go mod tidy

### Build/run


@run *args='':
  go run main.go $@

build:
  go build -o {{binary_name}} main.go

@optimized-run *args='': build && clean
  ./{{binary_name}} $@

# === toolbox-vim config ===

image_uri := "docker.io/mattjmcnaughton/toolbox-vim"
version := "0.0.1"  # TODO: Update version to latest.
image_name := image_uri + ":" + version
cwd := `pwd`
gopath := "{{cwd}}/.go"

dogfood: build
  GOPATH={{gopath}} ./{{binary_name}} run

vim:
  docker run -it \
    -v {{cwd}}:{{cwd}} \
    -e GOPATH="{{gopath}}" \
    -w {{cwd}} \
    {{image_name}} \
    /bin/bash

# We run w/ `--network none` to disable any network access.
vim-offline:
  docker run -it \
    -v {{cwd}}:{{cwd}} \
    -e GOPATH="{{gopath}}" \
    -w {{cwd}} \
    --network none \
    {{image_name}} \
    /bin/bash
