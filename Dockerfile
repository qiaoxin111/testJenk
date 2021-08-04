FROM node:10
COPY ./ /app
WORKDIR /app
# COPY ./node_modules ./node_modules
RUN npm install --registry https://registry.npm.taobao.org
RUN npm run build
RUN npm install -g pm2

FROM nginx
RUN mkdir /app
COPY --from=0 /app/dist /app
COPY nginx.conf /etc/nginx/nginx.conf

CMD ['pm2', 'start', 'server.js']

# CMD ["nginx", "-g", "daemon off;"]