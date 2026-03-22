# Stage 1: Build
FROM --platform=linux/arm64 golang:1.22-alpine AS builder

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -o bootstrap ./cmd/proxy

# Stage 2: Runtime
FROM --platform=linux/arm64 public.ecr.aws/lambda/provided:al2023

COPY --from=builder /app/bootstrap /var/task/bootstrap
RUN chmod +x /var/task/bootstrap

ENTRYPOINT ["/var/task/bootstrap"]