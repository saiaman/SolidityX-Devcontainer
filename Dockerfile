FROM node:lts-slim
RUN apt update
RUN apt install -y git build-essential cmake libboost-all-dev wget jq
RUN git clone https://github.com/dominant-strategies/SolidityX /SolidityX
WORKDIR /SolidityX
RUN mkdir build 
RUN cd build && cmake .. && make
COPY link_all_versions.sh /link_all_versions.sh
RUN chmod a+x /link_all_versions.sh
ENTRYPOINT [ "/link_all_versions.sh" ]
