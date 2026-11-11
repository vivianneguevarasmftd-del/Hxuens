# 1 этап: берем готовый бинарник xray
FROM teddysun/xray:latest AS xray-bin

# 2 этап: базовый образ с caddy
FROM alpine:latest

# Копируем бинарник Xray
COPY --from=xray-bin /usr/bin/xray /usr/bin/xray

# Устанавливаем caddy, envsubst (пакет gettext), curl и jq
RUN apk add --no-cache caddy gettext curl jq

WORKDIR /app

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
