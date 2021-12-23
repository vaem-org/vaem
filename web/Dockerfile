FROM node:16.13.1-alpine as build

ENV BASE=/admin/
ARG EMBED_URL
ARG GOOGLE_CLIENT_ID
ARG API_URL

RUN mkdir -p /build/embed-ui && \
    wget -q -O - 'https://github.com/vaem-org/embed-ui/tarball/7a4cf75d2770e18587126e19e1f6514cdadb4cb0' | \
    tar zxv -C /build/embed-ui --strip-components=1

WORKDIR /build/embed-ui

RUN yarn && yarn generate

RUN mkdir -p /build/admin-ui && \
    wget -q -O - 'https://github.com/vaem-org/admin-ui/tarball/c14beb0e5101c525e923878da766707be16c3213' | \
    tar zxv -C /build/admin-ui --strip-components=1

WORKDIR /build/admin-ui

RUN yarn && yarn generate

FROM nginx:1.21.4-alpine

ADD ./nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=build /build/admin-ui/dist /usr/share/nginx/html/admin
COPY --from=build /build/embed-ui/dist /usr/share/nginx/html/embed
