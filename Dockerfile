FROM centos:7
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
