# Faust Docker

A minimal Docker image embedding the [Faust](https://faust.grame.fr) compiler with all standard libraries and architecture files.

**Important:** This image generates source code only (C++, C, Rust, etc.), not executable binaries. The generated source code must be compiled using your local development tools and toolchain.

## About

[Faust](https://faust.grame.fr) (Functional Audio Stream) is a functional programming language specifically designed for real-time audio signal processing and sound synthesis. This Docker image allows you to use the Faust compiler without installing it locally.

## Features

- Lightweight Alpine Linux-based image
- Complete Faust compiler with all standard libraries
- All architecture files included
- Supports all code generation backends (C++, C, Rust, LLVM, etc.)
- **Note:** `faust2xxx` scripts are not included (binary generation not available)

## Installation

### From GitHub Container Registry

```bash
docker pull ghcr.io/orlarey/faustdocker:latest
```

### Build Locally

```bash
make image
```

## Usage

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

## Usage Examples

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
docker run -v $PWD:/tmp ghcr.io/orlarey/faustdocker -a juce-plugin.cpp foo.dsp
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

## Simplified Usage with Wrapper Script

A convenient bash script `faust` is provided to simplify usage. This script wraps the Docker command so you can use Faust as if it were installed locally.

### Installation

Copy the script to a directory in your PATH:

```bash
sudo cp faust /usr/local/bin/
sudo chmod +x /usr/local/bin/faust
```

Or add the script's directory to your PATH:

```bash
export PATH="/path/to/faustdocker:$PATH"
```

### Usage

Once installed, simply use:

```bash
faust foo.dsp
faust -lang cpp -o foo.cpp foo.dsp
faust -h
```

### Alternative: Shell Alias

Alternatively, you can create a shell alias without installing the script:

```bash
alias faust='docker run --rm -v $PWD:/tmp ghcr.io/orlarey/faustdocker'
```

Then use it the same way:

```bash
faust foo.dsp
faust -lang cpp -o foo.cpp foo.dsp
```

## Limitations

- `faust2xxx` scripts are **not** available
- Cannot generate binaries directly (source code only)
- External dependencies required by `faust2xxx` scripts are not installed
- Only source code compilation is supported

## Development

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