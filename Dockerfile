FROM ubuntu:20.04

# 安裝依賴，包括 curl
RUN apt-get update && apt-get install -y libpcre3 libssl1.1 zlib1g curl && rm -rf /var/lib/apt/lists/*

# 創建 NGINX 配置和預設工作目錄
RUN mkdir -p /etc/nginx /var/log/nginx /usr/local/nginx/logs /usr/local/nginx/client_body_temp /usr/local/nginx/proxy_temp /usr/local/nginx/fastcgi_temp /usr/local/nginx/uwsgi_temp /usr/local/nginx/scgi_temp

# 複製 NGINX 二進位檔案
COPY ./nginx-binary /usr/sbin/nginx

# 驗證模塊
RUN nginx -V 2>&1 | grep -q nginx_upstream_check_module || exit 1

# 指定配置文件路徑並啟動
CMD ["nginx", "-c", "/etc/nginx/nginx.conf", "-g", "daemon off;"]