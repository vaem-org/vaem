FROM node:20.11.1-alpine as build

ENV API_URL='${API_URL}'
ENV EMBED_URL='${EMBED_URL}'
ENV GOOGLE_CLIENT_ID='${GOOGLE_CLIENT_ID}'

RUN mkdir -p /build/embed-ui && \
    wget -q -O - 'https://github.com/vaem-org/embed-ui/tarball/797158c8c285e0a3149e97d4d32f5925a4da722c' | \
    tar zxv -C /build/embed-ui --strip-components=1

WORKDIR /build/embed-ui

ENV BASE=/embed/
RUN yarn && yarn generate

RUN mkdir -p /build/admin-ui && \
    wget -q -O - 'https://github.com/vaem-org/admin-ui/tarball/13bb5fe0f2076d92afde31f4f9b8d118c5a815fd' | \
    tar zxv -C /build/admin-ui --strip-components=1

WORKDIR /build/admin-ui

ENV BASE=/admin/
RUN yarn && yarn generate

FROM nginx:1.25.4-alpine

ADD ./nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=build /build/admin-ui/dist /usr/share/nginx/html/admin
COPY --from=build /build/embed-ui/dist /usr/share/nginx/html/embed

ADD ./update-variables.sh /docker-entrypoint.d/update-variables.sh
