FROM golang:alpine AS builder
RUN apk add --update git make
WORKDIR /go/src/github.com/google/mtail
COPY . /go/src/github.com/google/mtail
RUN  make depclean && make install_deps && PREFIX=/go make STATIC=y -B install
RUN chmod +x /go/src/github.com/google/mtail/debug.sh


FROM busybox:latest
WORKDIR /
USER root
COPY --from=builder /go/bin/mtail /mtail
COPY --from=builder /go/src/github.com/google/mtail/debug.sh /debug.sh
COPY --from=builder /go/src/github.com/google/mtail/main_control.sh /main_control.sh
RUN chmod +x /main_control.sh
RUN chmod +x /debug.sh
RUN mkdir /progs
EXPOSE 3903
