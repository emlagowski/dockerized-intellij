from openjdk:8u131-jdk

maintainer Marcin Łagowski <marcinlagowski92@gmail.com>

run wget https://download.jetbrains.com/idea/ideaIC-2017.1.4.tar.gz -O /tmp/ideaIC.tar.gz -q && \
	mkdir -p /opt/intellij && \
	tar -xzf /tmp/ideaIC.tar.gz --strip-components=1 -C /opt/intellij && \
	rm -rf /tmp/ideaIC.tar.gz

env DEBIAN_FRONTEND nointeractive

env USERNAME developer
run adduser --disabled-password --gecos '' $USERNAME && \
    echo $USERNAME:$USERNAME: | chpasswd && \ 
    echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    adduser $USERNAME sudo
user $USERNAME
workdir /home/$USERNAME

run mkdir /home/$USERNAME/IdeaProjects && \
    chown $USERNAME:$USERNAME /home/$USERNAME/IdeaProjects
run mkdir /home/$USERNAME/.IdeaIC2017.1 && \
    chown $USERNAME:$USERNAME /home/$USERNAME/.IdeaIC2017.1

cmd /opt/intellij/bin/idea.sh

