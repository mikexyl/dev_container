
# Note: You can use any Debian/Ubuntu based image you want. 
FROM voxgraph:melodic-tf1.14.0-perception

# Options
ARG INSTALL_ZSH="false"
ARG UPGRADE_PACKAGES="false"
ARG ENABLE_NONROOT_DOCKER="true"
ARG SOURCE_SOCKET=/var/run/docker-host.sock
ARG TARGET_SOCKET=/var/run/docker.sock

# This Dockerfile adds a non-root user with sudo access. Update the “remoteUser” property in
# devcontainer.json to use it. More info: https://aka.ms/vscode-remote/containers/non-root-user.
ARG USERNAME=lxy
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# # Install needed packages and setup non-root user. Use a separate RUN statement to add your own dependencies.
# COPY library-scripts/*.sh /tmp/library-scripts/
# RUN apt-get update \
#     && /bin/bash /tmp/library-scripts/common-debian.sh "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" "${UPGRADE_PACKAGES}" \
#     # Use Docker script from script library to set things up
#     && /bin/bash /tmp/library-scripts/docker-debian.sh "${ENABLE_NONROOT_DOCKER}" "${SOURCE_SOCKET}" "${TARGET_SOCKET}" "${USERNAME}" \
#     # Clean up
#     && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts/


# # Setting the ENTRYPOINT to docker-init.sh will configure non-root access to 
# # the Docker socket if "overrideCommand": false is set in devcontainer.json. 
# # The script will also execute CMD if you need to alter startup behaviors.
# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update \
#     && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>

#Avoiding extension reinstalls on container rebuild
# RUN mkdir -p /home/$USERNAME/.vscode-server/extensions \
#         /home/$USERNAME/.vscode-server-insiders/extensions \
#     && chown -R $USERNAME \
#         /home/$USERNAME/.vscode-server \
#         /home/$USERNAME/.vscode-server-insiders

RUN apt update && apt install python-pip -y
RUN pip install -U pylint
RUN apt update && apt install clang-format-8 -y
RUN ln -s /usr/bin/clang-format-8 /usr/bin/clang-format

RUN apt install libprotobuf-dev protobuf-compiler -y

RUN apt update && apt install gdb -y

RUN apt-get update \
  && apt-get install -y ssh \
      build-essential \
      gcc \
      g++ \
      gdb \
      clang-8 \
      cmake \
      rsync \
      tar \
      python \
  && apt-get clean

RUN ( \
    echo 'LogLevel DEBUG2'; \
    echo 'PermitRootLogin yes'; \
    echo 'PasswordAuthentication yes'; \
    echo 'Subsystem sftp /usr/lib/openssh/sftp-server'; \
  ) > /etc/ssh/sshd_config_test_clion \
  && mkdir /run/sshd

RUN yes password | passwd lxy

ENV CC /usr/lib/ccache/gcc
ENV CXX /usr/lib/ccache/g++

RUN apt update && apt install doxygen llvm-8-tools -y && apt clean
COPY clangd_11.0.0/bin/clangd /usr/bin
COPY clangd_11.0.0/lib/clang /usr/lib/clang

RUN apt update && apt install ccache -y 
ENV PATH "/usr/lib/ccache:$PATH"
RUN ccache --max-size=10G
RUN chown -R lxy /home/lxy/.ccache

RUN apt update && apt install xterm -y
