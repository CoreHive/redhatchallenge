FROM node:15.4.0-alpine3.12

ENV NODE_ENV production
ENV PORT 3000
# ENV USE_ZIPKIN

# We'll need this for testing the endpoints with helm test
RUN apk update;
RUN apk add wget;

WORKDIR "/app"

# Install app dependencies
COPY package*.json /app/
RUN cd /app;
RUN rm -rf ./node_modules;
RUN npm install;

# Bundle app source
COPY . /app

EXPOSE 3000

CMD ["npm", "start"]
