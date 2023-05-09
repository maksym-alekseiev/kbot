ARG TARGETARCH=arm64

FROM quay.io/projectquay/golang:1.20 as builder

WORKDIR /go/src/app
COPY . .

RUN make build

FROM scratch
WORKDIR /
COPY --from=builder /go/src/app/kbot .
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
ENTRYPOINT ["./kbot"]

FROM builder as linux
RUN make linux

FROM builder as windows
RUN make windows

FROM builder as macos
RUN make macos