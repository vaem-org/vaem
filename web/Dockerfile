FROM node:16.13.1-alpine as build

RUN apk add --no-cache git

RUN mkdir /build && cd /build && git clone https://github.com/vaem-org/admin-ui

ARG EMBED_URL
ARG GOOGLE_CLIENT_ID

WORKDIR /build/admin-ui

ENV BASE=/admin/
ENV API_URL=/api

RUN yarn && yarn generate

RUN cd /build && git clone https://github.com/vaem-org/embed-ui

WORKDIR /build/embed-ui

ENV BASE=/embed/

RUN yarn && yarn generate

FROM nginx:1.21.4-alpine

ADD ./nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=build /build/admin-ui/dist /usr/share/nginx/html/admin
COPY --from=build /build/embed-ui/dist /usr/share/nginx/html/embed
