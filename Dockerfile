FROM node:20-alpine AS builder
WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN corepack enable && pnpm install --frozen-lockfile
COPY . .
RUN pnpm exec vite build

FROM nginx:1.30.1
RUN mkdir -p /www/wwwroot /var/run/nginx /var/cache/nginx
COPY --from=builder /app/dist/ /www/wwwroot/
RUN mkdir -p /www/wwwroot/user/tool/ittool && \
    cp -r /www/wwwroot/assets /www/wwwroot/user/tool/ittool/ && \
    cp /www/wwwroot/index.html /www/wwwroot/user/tool/ittool/
RUN cat /www/wwwroot/user/tool/ittool/index.html | grep assets
RUN chown -R nginx:nginx /www/wwwroot \
 && chown -R nginx:nginx /var/cache/nginx \
 && chown -R nginx:nginx /var/run/ \
 && apt-get update && apt-get install -y libcap2-bin \
 && setcap 'cap_net_bind_service=+ep' /usr/sbin/nginx \
 && apt-get clean && rm -rf /var/lib/apt/lists/*
USER nginx
EXPOSE 80
