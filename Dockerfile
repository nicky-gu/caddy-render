# 使用官方的 Caddy 基础镜像
FROM caddy:latest

# 移除 setcap 权限
RUN setcap -r /usr/bin/caddy

# 将你的 Caddyfile 复制到 /etc/caddy/Caddyfile
COPY Caddyfile /etc/caddy/Caddyfile

# 暴露 HTTP 和 HTTPS 端口
EXPOSE 80
EXPOSE 443

# 启动 Caddy
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile"]
