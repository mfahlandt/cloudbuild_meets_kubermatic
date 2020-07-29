FROM golang:alpine AS builder

WORKDIR /build
COPY server.go .

RUN go build -o main .

WORKDIR /dist

RUN cp /build/main .


# Make it small
FROM scratch
COPY --from=builder /dist/main /

# Command to run
ENTRYPOINT ["/main"]