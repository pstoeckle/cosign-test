FROM golang:1.22.0-bookworm as build-env

WORKDIR /app

COPY test.go /app/test.go

ARG CGO_ENABLED=0

RUN go build -o test test.go

FROM gcr.io/distroless/static-debian12:nonroot

COPY --chown=nonroot --from=build-env /app/test /test

ENTRYPOINT [ "/test" ]
