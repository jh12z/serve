FROM golang AS builder
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 go build -a -tags netgo -ldflags '-w' -o serve main.go

FROM scratch
WORKDIR /
COPY --from=builder /app/serve .
EXPOSE 3000
CMD ["./serve", "/sites"]
