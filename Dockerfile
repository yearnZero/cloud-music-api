FROM node:lts-alpine

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    mkdir -p /logs && \
    rm -rf /var/cache/apk/*

WORKDIR /app
COPY . /app

RUN rm -f package-lock.json && \
    rm -rf .idea && \
    rm -rf node_modules && \
    npm config set registry "https://registry.npm.taobao.org/" && \
    yarn config set registry 'https://registry.npm.taobao.org' && \
    yarn global add pm2 && \
    yarn install && \
    yarn cache clean

VOLUME ["/logs"]

EXPOSE 3000

CMD ["pm2-runtime", "start", "app.js"]
