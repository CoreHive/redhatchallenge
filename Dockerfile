FROM centos:8

ADD https://rpm.nodesource.com/setup_8.x /root/
#RUN curl -sL https://rpm.nodesource.com/setup_8.x
RUN bash /root/setup_8.x ;\  
yum -y install nodejs ;\
yum -y install java-1.8.0-openjdk


RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
RUN source $HOME/.bashrc && nvm install 12.14.1

RUN ln -s $HOME/.nvm/versions/node/v12.14.1/bin/node /usr/bin/node
RUN ln -s $HOME/.nvm/versions/node/v12.14.1/bin/npm /usr/bin/npm

RUN node -v
RUN npm -v
