FROM node:16.13.1-alpine as build

ENV API_URL='${API_URL}'
ENV EMBED_URL='${EMBED_URL}'
ENV GOOGLE_CLIENT_ID='${GOOGLE_CLIENT_ID}'

RUN mkdir -p /build/embed-ui && \
    wget -q -O - 'https://github.com/vaem-org/embed-ui/tarball/241a07a2583d7c2efb5dc887483c5ea3a1409010' | \
    tar zxv -C /build/embed-ui --strip-components=1

WORKDIR /build/embed-ui

ENV BASE=/embed/
RUN yarn && yarn generate

RUN mkdir -p /build/admin-ui && \
    wget -q -O - 'https://github.com/vaem-org/admin-ui/tarball/4edf222286a90a41147b4954b07b3e59cd2dca51' | \
    tar zxv -C /build/admin-ui --strip-components=1

WORKDIR /build/admin-ui

ENV BASE=/admin/
RUN yarn && yarn generate

FROM nginx:1.21.4-alpine

ADD ./nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=build /build/admin-ui/dist /usr/share/nginx/html/admin
COPY --from=build /build/embed-ui/dist /usr/share/nginx/html/embed

ADD ./update-variables.sh /docker-entrypoint.d/update-variables.sh
