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
COPY /usr/share/zoneinfo/Asia/Shanghai /etc/Shanghai
RUN cd /etc && rm -f localtime && mv Shanghai localtime
RUN chmod +x /mainProcess
RUN mkdir /progs
CMD ["/bin/sh","/mainProcess"]
EXPOSE 3903
