FROM golang:alpine AS builder

ENV CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

WORKDIR /build
COPY server.go .

RUN go build -o main .

WORKDIR /dist

RUN cp /build/main .


# Make it small
FROM scratch
COPY --from=builder /dist/main /
EXPOSE 8080
# Command to run
ENTRYPOINT ["/main"]