FROM jenkins/jenkins:lts
USER root
RUN apt update && apt install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
RUN apt update && apt-cache policy docker-ce && apt install -y docker-ce
RUN curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose
RUN wget https://github.com/docker/machine/releases/download/v0.14.0/docker-machine-$(uname -s)-$(uname -m) && mv docker-machine-Linux-x86_64 docker-machine && chmod +x docker-machine && mv docker-machine /usr/local/bin
USER jenkins
