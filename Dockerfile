FROM golang:alpine AS builder
RUN apk add --update git make
RUN apk add tzdata
WORKDIR /go/src/github.com/google/mtail
COPY . /go/src/github.com/google/mtail
RUN  make depclean && make install_deps && PREFIX=/go make STATIC=y -B install


FROM busybox:latest
WORKDIR /
USER root
COPY --from=builder /go/bin/mtail /bin/mtail
COPY --from=builder /go/src/github.com/google/mtail/mainProcess /mainProcess
COPY --from=builder /usr/share/zoneinfo/Asia/Shanghai /usr/share/zoneinfo/Asia/Shanghai
COPY --from=builder /usr/share/zoneinfo/UTC /usr/share/zoneinfo/UTC
RUN chmod +x /mainProcess
RUN mkdir /progs
CMD ["/bin/ash","/mainProcess"]
EXPOSE 3903
