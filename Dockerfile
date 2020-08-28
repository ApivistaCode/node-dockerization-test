FROM node:12.18.3-alpine

# Create app directory
RUN mkdir /home/node/app/ && chown -R node:node /home/node/app

WORKDIR /home/node/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY --chown=node:node package*.json ./

USER node

RUN npm install && npm cache clean --force --loglevel=error

# Bundle app source
COPY --chown=node:node . .

EXPOSE 8080
CMD [ "node", "server.js" ]