#!/usr/bin/env sh
find /usr/share/nginx/html -type f \( -name "*.js" -o -name "*.html" \) -exec sed -i "s|\${API_URL}|${API_URL}|g;s|\${EMBED_URL}|${EMBED_URL}|g;s|\${GOOGLE_CLIENT_ID}|${GOOGLE_CLIENT_ID}|g" {} \;
