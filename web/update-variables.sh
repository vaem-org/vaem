#!/usr/bin/env sh
find /usr/share/nginx/html -type f \( -name "*.js" -o -name "*.html" \) -exec sed -i "s|\${NUXT_PUBLIC_API_URL}|${NUXT_PUBLIC_API_URL}|g;s|\${NUXT_PUBLIC_EMBED_URL}|${NUXT_PUBLIC_EMBED_URL}|g" {} \;
