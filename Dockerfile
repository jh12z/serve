FROM golang AS builder
WORKDIR /build
COPY . .
RUN CGO_ENABLED=0 go build -a -tags netgo -ldflags '-w' -o serve main.go

FROM scratch
WORKDIR /sites
COPY --from=builder /build/serve /serve
EXPOSE 3000
ENTRYPOINT ["/serve"]
CMD ["/sites"]
