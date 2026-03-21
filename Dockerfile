# --- שלב 1: Build ---
FROM --platform=linux/arm64 golang:1.22-alpine AS builder

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -o bootstrap ./cmd/proxy

# --- שלב 2: Runtime ---
FROM --platform=linux/arm64 public.ecr.aws/lambda/provided:al2023

COPY --from=builder /app/bootstrap /var/runtime/bootstrap
RUN chmod +x /var/runtime/bootstrap

CMD ["bootstrap"]