# ── Stage 1: Build Flutter Web ──
FROM ghcr.io/cirruslabs/flutter:stable AS build

ENV FLUTTER_ALLOW_ROOT=true

WORKDIR /app

# Copiar dependencias primero (cache layer)
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get --no-example

# Copiar el resto del proyecto
COPY . .

# Build web release — base-href /race/ para mavoo.fit/race
RUN flutter build web --release --base-href "/race/"

# ── Stage 2: Serve con Nginx ──
FROM nginx:alpine

# Copiar el build de Flutter a la raíz de nginx
# (Dokploy/Traefik stripea el prefijo /race antes de reenviar al contenedor)
COPY --from=build /app/build/web /usr/share/nginx/html

# Configuración de nginx para SPA
RUN echo 'server { \
    listen 80; \
    server_name _; \
    root /usr/share/nginx/html; \
    index index.html; \
    location / { \
        try_files $uri $uri/ /index.html; \
    } \
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|wasm)$ { \
        expires 1y; \
        add_header Cache-Control "public, immutable"; \
    } \
}' > /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

