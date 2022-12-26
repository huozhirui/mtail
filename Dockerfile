FROM golang:alpine AS builder
RUN apk add --update git make
WORKDIR /go/src/github.com/google/mtail
COPY . /go/src/github.com/google/mtail
RUN  make depclean && make install_deps && PREFIX=/go make STATIC=y -B install
RUN chmod +x /go/src/github.com/google/mtail/debug.sh


FROM busybox:latest
WORKDIR /
COPY --from=builder /go/bin/mtail /mtail
COPY --from=builder /go/src/github.com/google/mtail/debug.sh /debug.sh
COPY --from=builder /go/src/github.com/google/mtail/main_control.sh /main_control.sh
RUN chmod +x /main_control.sh
RUN chmod +x /debug.sh
RUN mkdir /progs
RUN mkdir /service_log
ENTRYPOINT ["/bin/ash /main_control"]
EXPOSE 3903




ARG version=0.0.0-local
ARG build_date=unknown
ARG commit_hash=unknown
ARG vcs_url=unknown
ARG vcs_branch=unknown

