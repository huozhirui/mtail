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
EXPOSE 3903




ARG version=0.0.0-local
ARG build_date=unknown
ARG commit_hash=unknown
ARG vcs_url=unknown
ARG vcs_branch=unknown

