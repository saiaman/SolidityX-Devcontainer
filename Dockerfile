FROM solbuildpackpusher/solidity-buildpack-deps:ubuntu2004-20 as build
RUN git clone https://github.com/dominant-strategies/SolidityX /SolidityX
WORKDIR /SolidityX
ENV CMAKE_OPTIONS " -DCMAKE_BUILD_TYPE=Release -DUSE_Z3_DLOPEN=ON -DUSE_CVC4=OFF -DSOLC_STATIC_STDLIBS=ON"
RUN scripts/ci/build.sh

FROM node:lts-slim
RUN apt update
RUN apt install -y wget jq
COPY --from=build /SolidityX/build/solc/solc /usr/bin/solc
COPY link_all_versions.sh /link_all_versions.sh
RUN chmod a+x /link_all_versions.sh
ENTRYPOINT [ "/link_all_versions.sh" ]
