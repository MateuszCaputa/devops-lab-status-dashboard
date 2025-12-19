# Base image: Use lightweight Nginx on Alpine Linux for production performance
FROM nginx:alpine-slim

# Metadata standards
LABEL maintainer="Mateusz Caputa"
LABEL version="1.0.0"
LABEL description="Nginx-based status dashboard"

# Remove default Nginx static assets
RUN rm -rf /usr/share/nginx/html/*

# Deploy application artifacts
COPY src/ /usr/share/nginx/html/

# Healthcheck configuration for container orchestrators
# Ensures the web server is responsive, not just running
HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD curl -f http://localhost/ || exit 1

# Expose standard HTTP port
EXPOSE 80

# Start Nginx in foreground mode
CMD ["nginx", "-g", "daemon off;"]