APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=maksymalekseiev
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS=linux
TARGETARCH=arm64

format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v

get:
	go get

build: format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/maksym-alekseiev/kbot/cmd.appVersion=${VERSION}
	
linux: format get
	CGO_ENABLED=0 GOOS=linux GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/maksym-alekseiev/kbot/cmd.appVersion=${VERSION}
	TARGETOS=linux

windows: format get
	CGO_ENABLED=0 GOOS=windows GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/maksym-alekseiev/kbot/cmd.appVersion=${VERSION}
	TARGETOS=windows

macos: format get
	CGO_ENABLED=0 GOOS=darwin GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/maksym-alekseiev/kbot/cmd.appVersion=${VERSION}
	TARGETOS=macos

image:
	docker build --target ${TARGETOS} --build-arg TARGETARCH=${TARGETARCH} . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

clean:
	rm -rf kbot
	docker rmi ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}