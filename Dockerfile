# Build stage
FROM golang:1.18 AS builder

WORKDIR /app
COPY . .
RUN go mod init go-web-app && go mod tidy && go build -o main .

# Final stage
FROM alpine:latest

WORKDIR /root/
COPY --from=builder /app/main .
EXPOSE 8080
CMD ["./main"]

