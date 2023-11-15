FROM solbuildpackpusher/solidity-buildpack-deps@sha256:ee1def5806f40c35d583234e172ec5769bb9a08b6f5bbc713c1a2658846dbced as build
RUN git clone https://github.com/dominant-strategies/SolidityX /SolidityX
WORKDIR /SolidityX
RUN git fetch --all && git checkout solc-0.8.19
ENV CMAKE_OPTIONS " -DCMAKE_BUILD_TYPE=Release -DUSE_Z3_DLOPEN=ON -DUSE_CVC4=OFF -DSOLC_STATIC_STDLIBS=ON -DSTRICT_Z3_VERSION=OFF"
RUN scripts/ci/build.sh

FROM node:lts-slim
RUN apt update
RUN apt install -y wget jq
COPY --from=build /SolidityX/build/solc/solc /usr/bin/solc
COPY link_all_versions.sh /link_all_versions.sh
RUN chmod a+x /link_all_versions.sh
ENTRYPOINT [ "/link_all_versions.sh" ]
