FROM jenkins/jenkins:lts

USER root
# VER=$(shell dpkg-parsechangelog --show-field Version)
# REL=$(shell lsb_release -rsu || lsb_release -rs)
# CDN=$(shell lsb_release -csu || lsb_release -cs)

RUN apt update && apt install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
# see https://www.virtualbox.org/wiki/Linux_Downloads
RUN wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | apt-key add -
RUN wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | apt-key add -
#RUN add-apt-repository "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"
RUN add-apt-repository "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib non-free" --yes

RUN curl -fsSL https://download.docker.com/$(uname -s | tr '[:upper:]' '[:lower:]')/$(lsb_release -si | tr '[:upper:]' '[:lower:]')/gpg | apt-key add - 
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/$(uname -s | tr '[:upper:]' '[:lower:]')/$(lsb_release -si | tr '[:upper:]' '[:lower:]') $(lsb_release -cs) stable"
#RUN apt update && apt-cache policy docker-ce && apt install -y docker-ce dkms virtualbox-5.0
#RUN apt update && apt-cache policy docker-ce && apt install -y docker-ce dkms virtualbox-6.0
#RUN apt update && apt-cache policy docker-ce && apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose
RUN apt update && apt-cache policy docker-ce && apt-get install -y docker-ce docker-ce-cli containerd.io
#RUN apt update && apt-cache policy virtualbox && apt install -y docker-ce dkms virtualbox-6.0

# Please also use version 5.2 if you still need support for 32-bit hosts, as this has been discontinued in 6.0. Version 5.2 will remain supported until July 2020. 
#RUN apt update && apt install dkms linux-headers-generic binfmt-support && virtualbox-5.2
# Please also use version 6.0 if you need to run VMs with software virtualization, as this has been discontinued in 6.1. Version 6.0 will remain supported until July 2020.
#RUN apt update && apt install dkms linux-headers-generic binfmt-support && virtualbox-6.0
RUN apt update && apt install dkms linux-headers-generic binfmt-support && virtualbox-6.1

#RUN curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose
#RUN curl -L https://github.com/docker/compose/releases/download/last/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose
# see https://help.github.com/en/github/administering-a-repository/linking-to-releases
# https://gist.github.com/steinwaywhw/a4cd19cda655b8249d908261a62687f8
# https://github.com/github/hub
# https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c
RUN curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose


#RUN wget https://github.com/docker/machine/releases/download/v0.14.0/docker-machine-$(uname -s)-$(uname -m) && mv docker-machine-Linux-x86_64 docker-machine && chmod +x docker-machine && mv docker-machine /usr/local/bin
RUN curl -L https://github.com/docker/machine/releases/latest/download/docker-machine-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-machine && chmod +x /usr/local/bin/docker-machine

USER jenkins


# clean up  
RUN sudo apt-get clean && \  
sudo rm -rf /var/lib/apt/lists/*  
  
# automatically start virtualbox  
##ENTRYPOINT ["/usr/bin/virtualbox"]  
