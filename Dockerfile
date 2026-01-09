
########################################################################
########################################################################
#
#       		  Faust in a docker container
#                 (Y. Orlarey)
#
########################################################################
########################################################################

ARG BASE_IMAGE=alpine:20251224

FROM ${BASE_IMAGE} 

RUN apk update 
RUN apk add --no-cache gcc musl-dev cmake g++ make git pkgconfig

# Build Faust
RUN git clone https://github.com/grame-cncm/faust.git
WORKDIR /faust
RUN git fetch && git checkout 26d2c3daeefa9384ef256a6940f7251ab193fd57
RUN make -C /faust/build cmake CMAKEOPT='-DFAUST_DEFINITIONS="-DALPINE"'
RUN make -C /faust/build
RUN make -C /faust/build install

FROM ${BASE_IMAGE}

RUN apk add --no-cache libstdc++

# Install Faust without faust2xxx scripts (they can't be used)
COPY --from=0 /usr/local/bin/faust /usr/local/bin/faustoptflags /usr/local/bin/usage.sh /usr/local/bin/filename2ident /usr/local/bin/sound2reader /usr/local/bin 
COPY --from=0 /usr/local/share/faust/ /usr/local/share/faust/
COPY --from=0 /usr/local/include/faust/ /usr/local/include/faust/

WORKDIR /tmp

ENTRYPOINT [ "/usr/local/bin/faust" ]
CMD [ "-v" ]
