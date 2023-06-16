FROM node:16-alpine

ENV CHROME_BIN=/usr/bin/chromium-browser
ENV CHROME_PATH=/usr/lib/chromium/
ENV MEMORY_CACHE=0
ENV PORT=2800

# A timeout can be set here or in the kubernetes
# environment variables. This is for sites that
# take extra time (for animations etc) before the
# screen is loaded.
# ENV WAIT_AFTER_LAST_REQUEST=5000

# install chromium, tini and clear cache
RUN apk add --update-cache chromium tini \
 && rm -rf /var/cache/apk/* /tmp/*

USER node
WORKDIR "/home/node"

COPY ./package.json .
COPY ./server.js .

# install npm packages
RUN npm install --no-package-lock

EXPOSE 2800

ENTRYPOINT ["tini", "--"]
CMD ["node", "server.js"]