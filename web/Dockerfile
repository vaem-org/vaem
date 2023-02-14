FROM node:16.13.1-alpine as build

ENV API_URL='${API_URL}'
ENV EMBED_URL='${EMBED_URL}'
ENV GOOGLE_CLIENT_ID='${GOOGLE_CLIENT_ID}'

RUN mkdir -p /build/embed-ui && \
    wget -q -O - 'https://github.com/vaem-org/embed-ui/tarball/efced9133c1c1a17536115d2daf0d5769b11f16c' | \
    tar zxv -C /build/embed-ui --strip-components=1

WORKDIR /build/embed-ui

ENV BASE=/embed/
RUN yarn && yarn generate

RUN mkdir -p /build/admin-ui && \
    wget -q -O - 'https://github.com/vaem-org/admin-ui/tarball/3307f52c05198875ba8ad24bc849a06a82ae8ed1' | \
    tar zxv -C /build/admin-ui --strip-components=1

WORKDIR /build/admin-ui

ENV BASE=/admin/
RUN yarn && yarn generate

FROM nginx:1.21.4-alpine

ADD ./nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=build /build/admin-ui/dist /usr/share/nginx/html/admin
COPY --from=build /build/embed-ui/dist /usr/share/nginx/html/embed

ADD ./update-variables.sh /docker-entrypoint.d/update-variables.sh
