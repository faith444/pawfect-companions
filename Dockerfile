# Use lightweight nginx to serve static site
FROM nginx:alpine

# ensure wget is available for healthcheck (small extra package)
RUN apk add --no-cache wget

# Clear default nginx html (optional but clean)
RUN rm -rf /usr/share/nginx/html/*

# Copy repository files into nginx web root
COPY . /usr/share/nginx/html

# Simple healthcheck that requests the root page
HEALTHCHECK --interval=30s --timeout=3s CMD wget -qO- http://localhost/ >/dev/null || exit 1

# Expose standard HTTP port
EXPOSE 80

# Run nginx in foreground
CMD ["nginx", "-g", "daemon off;"]
