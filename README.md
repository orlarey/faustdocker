# faustdocker

A minimal docker image embedding the Faust compiler with all the libraries and architecture files, but not the faust2xxx script (because the dependencies required by the various faust2xxx are not installed).

- Use `make` to build the image `ghcr.io/orlarey/faustdocker`.
- Use `docker run ghcr.io/orlarey/faustdocker -h` for help, 
- Use `docker run -v $PWD:/tmp ghcr.io/orlarey/faustdocker foo.dsp` to compile the file `foo.dsp` in current directory. 
- Use `docker run -v /path:/tmp ghcr.io/orlarey/faustdocker foo.dsp` to compile the file `foo.dsp` in directory `path`. 
 
All Faust options are available, as well as the Faust libraries and the faust architectures. But note that the `faust2xxx` tools are no available and that you *can't* use this docker image to generate any binaries. Only source code compilation is available.