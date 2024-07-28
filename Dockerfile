# 使用官方的 Caddy builder 镜像
FROM caddy:builder AS builder

# 构建 Caddy 并包含 forward_proxy 和 Cloudflare DNS 插件
RUN xcaddy build \
    --with github.com/caddyserver/forwardproxy \
    --with github.com/caddy-dns/cloudflare

# 使用官方的 Caddy 镜像作为基础
FROM caddy:latest

# 将自定义构建的 Caddy 二进制文件复制到最终镜像中
COPY --from=builder /usr/bin/caddy /usr/bin/caddy

# 将你的 Caddyfile 复制到 /etc/caddy/Caddyfile
COPY Caddyfile /etc/caddy/Caddyfile

# 暴露 HTTPS 端口
EXPOSE 443

# 移除 setcap 权限（提升安全性）
RUN setcap -r /usr/bin/caddy

# 启动 Caddy
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile"]
