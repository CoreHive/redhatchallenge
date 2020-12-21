FROM debian:stretch-slim

RUN groupadd --gid 1000 node \
  && useradd --uid 1000 --gid node --shell /bin/bash --create-home node

ENV NODE_VERSION 15.4.0

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

#RUN npm install -g npm@7.3.0
RUN npm install
# If you are building your code for production
# RUN npm ci --only=production

#RUN apt-get update -y

# Install ODBC drivers
#RUN apk add unixODBC unixODBC-devel

RUN apt-get update -y \
    && apt install python3 -y \
    && apt install python3-pip -y \
    && apt install python3-venv -y \
    && python3 -m venv venv


RUN apt-get -y install curl

**#Install FreeTDS and dependencies for PyODBC**
RUN apt-get update && apt-get install -y tdsodbc unixodbc-dev \
 && apt install unixodbc-bin -y  \
 && apt-get clean -y

RUN apt-get update
RUN apt-get install -y tdsodbc unixodbc-dev
RUN apt install unixodbc-bin -y
RUN apt-get clean -y

RUN pip install pandas
RUN pip install pyodbc
RUN pip install DateTime
RUN pip install multiprocess
RUN pip install threaded

## unixODBC
##RUN apt-get install -y unixodbc-dev unixodbc-bin unixodbc

# Bundle app source
COPY . .

EXPOSE 8080
CMD [ "node", "index.js", "database.js" ]
