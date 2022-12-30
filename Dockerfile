FROM golang:alpine AS builder
RUN apk add --update git make
WORKDIR /go/src/github.com/google/mtail
COPY . /go/src/github.com/google/mtail
RUN  make depclean && make install_deps && PREFIX=/go make STATIC=y -B install


FROM busybox:latest
WORKDIR /
USER root
COPY --from=builder /go/bin/mtail /bin/mtail
COPY --from=builder /go/src/github.com/google/mtail/mainProcess /mainProcess
RUN mv /etc/localtime /etc/localtime.bak
RUN chmod +x /mainProcess
RUN mkdir /progs
EXPOSE 3903
