####### Builder Stage #######

FROM golang:1.20-alpine as builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod tidy

COPY . .

RUN go build -o bin .


######## Runner Stage ########

FROM alpine:latest as runner

WORKDIR /app

COPY --from=builder /app/bin /app/bin

EXPOSE 5000

CMD ["/app/bin"]