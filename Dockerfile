FROM node:alpine

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

RUN yum update -y

# Install ODBC drivers
RUN yum install -y unixODBC unixODBC-devel

## unixODBC
##RUN apt-get install -y unixodbc-dev unixodbc-bin unixodbc

# Bundle app source
COPY . .

EXPOSE 8080
CMD [ "node", "index.js" , "database.js" ]
