### STAGE 1: Build Static Content ###
FROM node:alpine as builder
RUN apk add --update bash vim less git
RUN apk add --update tar g++ python make

COPY package.json /
RUN npm set progress=false && npm config set depth 0 && npm cache clean --force

## Storing node modules on a separate layer will prevent unnecessary npm installs at each build
RUN npm i --unsafe-perm && mkdir /app && cp -R /node_modules /app
WORKDIR /app
COPY . .
RUN npm run prod

### STAGE 2: Setup ###
FROM nginx:alpine
RUN apk add --update bash vim less git
RUN apk add --update libressl certbot

RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /app/dist /usr/share/nginx/html

COPY static/error /usr/share/nginx/html
COPY nginx/* /root/
RUN chmod +x /root/*.sh

EXPOSE 80
EXPOSE 443

CMD ["/root/start.sh"]
#CMD ["nginx", "-g", "daemon off;"]
