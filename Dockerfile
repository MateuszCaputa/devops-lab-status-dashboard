# BASE IMAGE: Use lightweight Nginx on Alpine Linux for production performance
FROM nginx:alpine-slim

# METADATA
LABEL maintainer="DevOps Engineer"
LABEL description="Lightweight Nginx server for Status Dashboard"

# CLEANUP: Remove default Nginx static files to avoid confusion
RUN rm -rf /usr/share/nginx/html/*

# INSTALLATION: Copy our source code to Nginx web root directory
COPY src/ /usr/share/nginx/html/

# SECURITY: Healthcheck ensures the container is actually processing requests
# If curl fails (exit 1), Docker will mark container as 'unhealthy'
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost/ || exit 1

# NETWORKING: Document that the container listens on port 80
EXPOSE 80

# EXECUTION: Start Nginx in foreground mode (required for containers)
CMD ["nginx", "-g", "daemon off;"]