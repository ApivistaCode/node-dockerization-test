FROM node:12.18.3-alpine

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install
# If you are building your code for production
# RUN npm ci --only=production

# Bundle app source
COPY . .

EXPOSE 8080
CMD [ "node", "server.js" ]

# RUN addgroup pyrunner \
#   && adduser -S -G pyrunner pyrunner \
#   && apk add --no-cache bash gcc musl-dev \
#   && mkdir /app 
# WORKDIR /app
# ADD . /app
# RUN chown -R pyrunner.pyrunner /app
# USER pyrunner
# RUN pip3 install --user -r requirements.txt