FROM ubuntu:22.04

SHELL [ "/bin/bash", "-c" ]

ARG PYTHON_VERSION_TAG=3.9
ARG LINK_PYTHON_TO_PYTHON3=1

RUN apt-get -qq -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get -qq -y install \
        gcc \
        g++ \
        wget \
        curl \
        git \
        make \
        sudo \
        bash-completion \
        tree \
        software-properties-common && \
    mv /usr/bin/lsb_release /usr/bin/lsb_release.bak && \
    apt-get -y autoclean && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*

COPY install_python.sh install_python.sh
RUN bash install_python.sh ${PYTHON_VERSION_TAG} ${LINK_PYTHON_TO_PYTHON3} && \
    rm -r install_python.sh Python-${PYTHON_VERSION_TAG}

# Enable tab completion by uncommenting it from /etc/bash.bashrc
# The relevant lines are those below the phrase "enable bash completion in interactive shells"
RUN export SED_RANGE="$(($(sed -n '\|enable bash completion in interactive shells|=' /etc/bash.bashrc)+1)),$(($(sed -n '\|enable bash completion in interactive shells|=' /etc/bash.bashrc)+7))" && \
    sed -i -e "${SED_RANGE}"' s/^#//' /etc/bash.bashrc && \
    unset SED_RANGE

# Use C.UTF-8 locale to avoid issues with ASCII encoding
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# WORKDIR /home/docker/data
# ENV HOME /home/docker
# ENV USER docker
# USER docker
# ENV PATH /home/docker/.local/bin:$PATH
# # Avoid first use of sudo warning. c.f. https://askubuntu.com/a/22614/781671
# RUN touch $HOME/.sudo_as_admin_successful

CMD [ "/bin/bash" ]
