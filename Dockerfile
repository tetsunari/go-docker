# Base image
FROM golang:1.23-alpine AS base

# Set working directory
WORKDIR /app

# Install necessary packages
RUN apk add --no-cache git

# Development stage with air
FROM base AS dev

# Install air (compatible with Go 1.23)
RUN go install github.com/air-verse/air@v1.61.7

# Copy source code (will be overridden by volume mount during development)
COPY . .

# Start air
CMD ["air", "-c", ".air.toml"]

# Build stage
FROM base AS builder

# Copy go.mod and go.sum first for dependency caching
COPY go.mod go.sum ./

# Download dependencies with cache mount for efficiency
RUN --mount=type=cache,target=/go/pkg/mod/ \
    go mod download

# Copy source code
COPY . .

# Build static binary without CGO with cache mount
RUN --mount=type=cache,target=/go/pkg/mod/ \
    --mount=type=cache,target=/root/.cache/go-build \
    CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

# Production stage (lightweight image)
FROM gcr.io/distroless/static-debian12:nonroot AS runner

# Set working directory
WORKDIR /

# Copy built binary
COPY --from=builder /app/main .

# Run as non-root user
USER nonroot:nonroot

# Run application
CMD ["./main"]