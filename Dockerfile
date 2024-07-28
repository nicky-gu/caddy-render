# 使用官方的 Caddy 基础镜像
FROM caddy:latest

# 将你的 Caddyfile 复制到 /etc/caddy/Caddyfile
COPY Caddyfile /etc/caddy/Caddyfile

# 暴露 HTTPS 端口
EXPOSE 443

# 移除 setcap 权限（提升安全性）
RUN setcap -r /usr/bin/caddy

# 启动 Caddy
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile"]
