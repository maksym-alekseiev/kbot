ARG TARGETOS
ARG TARGETARCH

FROM --platform=${TARGETOS}/${TARGETARCH} quay.io/projectquay/golang:1.20 as builder

WORKDIR /go/src/app
COPY . .
RUN make target TARGETOS=${TARGETOS} target TARGETARCH=${TARGETARCH} build .

FROM scratch
WORKDIR /
COPY --from=builder /go/src/app/kbot .
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
ENTRYPOINT ["./kbot"]