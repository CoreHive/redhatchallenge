FROM buildpack-deps:buster

#RUN groupadd --gid 1000 node \
#  && useradd --uid 1000 --gid node --shell /bin/bash --create-home node

ENV NODE_VERSION 15.4.0

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./
COPY ibm-iaccess-1.1.0.14-1.0.x86_64.rpm ./

#RUN npm install -g npm@7.3.0
##RUN npm install
##RUN npm install body-parser
# If you are building your code for production
# RUN npm ci --only=production

#RUN yum update -y

# Install ODBC drivers
#RUN apk add unixODBC unixODBC-devel
RUN yum update -y ibm-iaccess-1.1.0.14-1.0.x86_64.rpm

RUN yum update -y \
    && yum install python3 -y \
    && yum install python3-pip -y \
    && yum install python3-venv -y \
    && python3 -m venv venv


RUN yum -y install curl

####Install FreeTDS and dependencies for PyODBC**
RUN yum update && yum install -y tdsodbc unixodbc-dev \
 && yum install unixodbc-bin -y  \
 && yum clean -y

RUN yum update -y
RUN yum install -y tdsodbc unixodbc-dev
RUN yum install unixodbc-bin -y
RUN yum clean all

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
