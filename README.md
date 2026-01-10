# Faust Docker

A minimal Docker image embedding the [Faust](https://faust.grame.fr) compiler with all standard libraries and architecture files.

- Lightweight Alpine Linux-based image
- Complete Faust compiler with all standard libraries
- All architecture files included
- Supports all code generation backends (C++, C, Rust, LLVM, etc.)
- Multi-architecture support (AMD64, ARM64) - works on Intel/AMD and Apple Silicon

**Important:** This image generates source code only (C++, C, Rust, etc.), not executable binaries. The generated source code must be compiled using your local development tools and toolchain.

## `faust` Wrapper Script

A convenient bash script `faust` is provided to simplify usage. This script wraps the Docker command so you can use Faust (nearly) as if it were installed locally. The script automatically downloads the Docker image if it's not already present.


### Option 1: Download from Repository

Copy the script to a directory in your PATH:

```bash
curl -o faust https://raw.githubusercontent.com/orlarey/faustdocker/main/faust
sudo mv faust /usr/local/bin/
sudo chmod +x /usr/local/bin/faust
```

### Option 2: Create Manually

Create a file named `faust` with the following content:

```bash
#!/bin/bash

########################################################################
########################################################################
#
#       Faust Docker Wrapper Script
#       (Y. Orlarey)
#
#       This script simplifies the usage of the Faust compiler
#       running in a Docker container.
#
########################################################################
########################################################################

IMAGE="ghcr.io/orlarey/faustdocker:main"
docker run --rm -v "$PWD:/tmp" "$IMAGE" "$@"
```

Then make it executable and move it to your PATH:

```bash
chmod +x faust
sudo mv faust /usr/local/bin/
```

### Usage

Once installed, simply use:

```bash
faust foo.dsp
faust -lang cpp -o foo.cpp foo.dsp
faust -h
```

## Direct Docker Usage

If you prefer to use Docker directly without the wrapper script, here are some examples:

### Display Help

```bash
docker run ghcr.io/orlarey/faustdocker -h
```

### Display Version

```bash
docker run ghcr.io/orlarey/faustdocker -v
```

### Compile a .dsp File

To compile a Faust file in the current directory:

```bash
docker run -v $PWD:/tmp ghcr.io/orlarey/faustdocker foo.dsp
```

To compile a file in a specific directory:

```bash
docker run -v /path/to/directory:/tmp ghcr.io/orlarey/faustdocker foo.dsp
```

### Generate C++ Code

```bash
docker run -v $PWD:/tmp ghcr.io/orlarey/faustdocker -lang cpp -o foo.cpp foo.dsp
```

### Generate C Code

```bash
docker run -v $PWD:/tmp ghcr.io/orlarey/faustdocker -lang c -o foo.c foo.dsp
```

### Generate Rust Code

```bash
docker run -v $PWD:/tmp ghcr.io/orlarey/faustdocker -lang rust -o foo.rs foo.dsp
```

### Use a Specific Architecture

```bash
docker run -v $PWD:/tmp ghcr.io/orlarey/faustdocker -i -a juce-plugin.cpp foo.dsp
```

### Generate SVG Diagram

```bash
docker run -v $PWD:/tmp ghcr.io/orlarey/faustdocker -svg foo.dsp
```

### Advanced Compilation Options

```bash
# With optimizations
docker run -v $PWD:/tmp ghcr.io/orlarey/faustdocker -vec -lv 1 -o foo.cpp foo.dsp

# Double precision mode
docker run -v $PWD:/tmp ghcr.io/orlarey/faustdocker -double -o foo.cpp foo.dsp

# With JSON metadata
docker run -v $PWD:/tmp ghcr.io/orlarey/faustdocker -json -o foo.cpp foo.dsp
```

## Development

For developers who want to build and customize the Docker image:



### Available Commands

```bash
make image    # Build the Docker image
make test     # Test the image (displays version)
make push     # Push the image to the registry
```

## License

See the [LICENSE](LICENSE) file.

## Useful Links

- [Official Faust Website](https://faust.grame.fr)
- [Faust Documentation](https://faustdoc.grame.fr)
- [Faust GitHub Repository](https://github.com/grame-cncm/faust)
- [Faust Online IDE](https://faustide.grame.fr)