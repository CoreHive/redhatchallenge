FROM centos:8
ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]
##CMD ["/usr/sbin/init"]

ADD https://rpm.nodesource.com/setup_15.x /root/
#RUN curl -sL https://rpm.nodesource.com/setup_8.x
RUN bash /root/setup_15.x ;\  
yum -y install nodejs ;\
yum -y install python ;\
yum -y install java-1.8.0-openjdk ;\
yum -y update

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
#RUN source $HOME/.bashrc && nvm install 12.14.1
#RUN source $HOME/.bashrc && nvm install 15.2.1
RUN source $HOME/.bashrc && nvm install node

#RUN ln -s $HOME/.nvm/versions/node/v12.14.1/bin/node /usr/bin/node
#RUN ln -s $HOME/.nvm/versions/node/v12.14.1/bin/npm /usr/bin/npm

RUN node -v
RUN npm -v

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

COPY ibm-iaccess-1.1.0.14-1.0.ppc64le.rpm ./

RUN yum install -y ibm-iaccess-1.1.0.14-1.0.ppc64le.rpm ;\
yum install -y unixODBC unixODBC-devel


RUN npm --registry http://registry.npmjs.org/ install -g express
RUN npm --registry http://registry.npmjs.org/ install -g pug
RUN npm --registry http://registry.npmjs.org/ install -g odbc
RUN npm --registry http://registry.npmjs.org/ install -g body-parser
#RUN npm --registry http://registry.node-modules.io/ install -g express
#RUN npm --registry http://registry.node-modules.io/ install -g pug
#RUN npm --registry http://registry.node-modules.io/ install -g odbc
#RUN npm --registry http://registry.node-modules.io/ install -g body-parser
#RUN npm install express pug odbc
#RUN npm install body-parser

# Bundle app source
COPY . .

EXPOSE 8080
CMD [ "node", "index.js" ]
CMD [ "node", "database.js" ]
