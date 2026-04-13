FROM node:24.14.1-alpine AS build

RUN corepack enable

ENV NUXT_PUBLIC_API_URL='${NUXT_PUBLIC_API_URL}'
ENV NUXT_PUBLIC_EMBED_URL='${NUXT_PUBLIC_EMBED_URL}'

RUN mkdir -p /build/embed-ui && \
    wget -q -O - 'https://github.com/vaem-org/embed-ui/tarball/a5438205f1556fd4a4d11a74c7d38dd186696ccd' | \
    tar zxv -C /build/embed-ui --strip-components=1

WORKDIR /build/embed-ui

ENV NUXT_APP_BASE_URL=/embed/
RUN pnpm install && pnpm generate

RUN mkdir -p /build/admin-ui && \
    wget -q -O - 'https://github.com/vaem-org/admin-ui/tarball/1bb8477f5e42194d1b30154d7b63608cbf832a50' | \
    tar zxv -C /build/admin-ui --strip-components=1

WORKDIR /build/admin-ui

ENV NUXT_APP_BASE_URL=/admin/
RUN pnpm install && pnpm generate

FROM nginx:1.29.8-alpine

ADD ./nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=build /build/admin-ui/dist /usr/share/nginx/html/admin
COPY --from=build /build/embed-ui/dist /usr/share/nginx/html/embed

ADD ./update-variables.sh /docker-entrypoint.d/update-variables.sh
