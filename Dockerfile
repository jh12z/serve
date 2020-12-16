FROM golang AS build
WORKDIR /build
COPY . .
RUN CGO_ENABLED=0 go build -tags netgo -ldflags '-w' -o serve main.go

FROM scratch AS runtime
COPY --from=build /build/serve /serve
WORKDIR /sites
EXPOSE 3000
ENTRYPOINT ["/serve"]
CMD ["/sites"]
