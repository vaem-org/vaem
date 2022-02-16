FROM node:16.13.1-alpine as build

ENV API_URL='${API_URL}'
ENV EMBED_URL='${EMBED_URL}'
ENV GOOGLE_CLIENT_ID='${GOOGLE_CLIENT_ID}'

RUN mkdir -p /build/embed-ui && \
    wget -q -O - 'https://github.com/vaem-org/embed-ui/tarball/7a4cf75d2770e18587126e19e1f6514cdadb4cb0' | \
    tar zxv -C /build/embed-ui --strip-components=1

WORKDIR /build/embed-ui

ENV BASE=/embed/
RUN yarn && yarn generate

RUN mkdir -p /build/admin-ui && \
    wget -q -O - 'https://github.com/vaem-org/admin-ui/tarball/41515fec84e2fb300af5297130ed98623cb2c483' | \
    tar zxv -C /build/admin-ui --strip-components=1

WORKDIR /build/admin-ui

ENV BASE=/admin/
RUN yarn && yarn generate

FROM nginx:1.21.4-alpine

ADD ./nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=build /build/admin-ui/dist /usr/share/nginx/html/admin
COPY --from=build /build/embed-ui/dist /usr/share/nginx/html/embed

ADD ./update-variables.sh /docker-entrypoint.d/update-variables.sh
