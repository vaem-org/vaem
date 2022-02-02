FROM node:16.13.1-alpine as build

ARG EMBED_URL
ARG GOOGLE_CLIENT_ID
ARG API_URL

RUN mkdir -p /build/embed-ui && \
    wget -q -O - 'https://github.com/vaem-org/embed-ui/tarball/7a4cf75d2770e18587126e19e1f6514cdadb4cb0' | \
    tar zxv -C /build/embed-ui --strip-components=1

WORKDIR /build/embed-ui

ENV BASE=/embed/
RUN yarn && yarn generate

RUN mkdir -p /build/admin-ui && \
    wget -q -O - 'https://github.com/vaem-org/admin-ui/tarball/b3cf54cfab0a7eb66f3a1cbc933da86335931b6e' | \
    tar zxv -C /build/admin-ui --strip-components=1

WORKDIR /build/admin-ui

ENV BASE=/admin/
RUN yarn && yarn generate

FROM nginx:1.21.4-alpine

ADD ./nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=build /build/admin-ui/dist /usr/share/nginx/html/admin
COPY --from=build /build/embed-ui/dist /usr/share/nginx/html/embed
