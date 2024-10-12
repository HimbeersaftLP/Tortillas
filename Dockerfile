FROM debian:bookworm-slim

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && apt-get upgrade -y \
  && apt-get install --no-install-recommends -y qemu-utils qemu-system-x86 python3 python3-yaml build-essential cmake gcc-x86-64-linux-gnu g++-x86-64-linux-gnu

RUN mkdir /tortillas

WORKDIR /tortillas

COPY . .

VOLUME /sweb
VOLUME /output

CMD python3 -m tortillas -S /sweb && \
    mv /tmp/sweb/tortillas_summary.md /output/ && \
    bash -c 'for file in /tmp/sweb/tortillas/**/out.log; do new="${file:20}"; new="${new%/out.log}"; mv "${file}" "/output/${new}.log"; done'
