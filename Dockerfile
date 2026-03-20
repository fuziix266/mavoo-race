# ── Stage 1: Build Flutter Web ──
FROM ghcr.io/cirruslabs/flutter:3.32.2 AS build

WORKDIR /app

# Copiar dependencias primero (cache layer)
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get

# Copiar el resto del proyecto
COPY . .

# Build web release
RUN flutter build web --release --base-href "/"

# ── Stage 2: Serve con Nginx ──
FROM nginx:alpine

# Copiar el build de Flutter al directorio de nginx
COPY --from=build /app/build/web /usr/share/nginx/html

# Configuración de nginx para SPA (single page app)
RUN echo 'server { \
    listen 80; \
    server_name _; \
    root /usr/share/nginx/html; \
    index index.html; \
    location / { \
        try_files $uri $uri/ /index.html; \
    } \
    # Cache de assets estáticos \
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|wasm)$ { \
        expires 1y; \
        add_header Cache-Control "public, immutable"; \
    } \
}' > /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
