FROM voxgraph_dev

RUN apt-get remove --purge vim vim-runtime vim-gnome vim-tiny vim-gui-common

RUN apt-get update                                             \
  && apt-get install -y                                         \
    autoconf                                                    \
    automake                                                    \
    cmake                                                       \
    fish                                                        \
    g++                                                         \
    gettext                                                     \
    git                                                         \
    libtool                                                     \
    libtool-bin                                                 \
    lua5.3                                                      \
    ninja-build                                                 \
    pkg-config                                                  \
    unzip                                                       \
    xclip                                                       \
    xfonts-utils                                                \
  && apt-get clean all

RUN apt-get install checkinstall
RUN rm -rf /usr/local/share/vim /usr/bin/vim

COPY vim ${HOME}/vim

RUN apt-get install -y python-dev ruby-dev libperl-dev libncurses5-dev libatk1.0-dev libx11-dev libxpm-dev libxt-dev

RUN apt install -y python3-dev

ENV LUA_PREFIX /usr/local

RUN cd ${HOME}/vim && ./configure \
  --enable-multibyte \
  --enable-perlinterp=dynamic \
  --enable-rubyinterp=dynamic \
  --with-ruby-command=/usr/bin/ruby \
  # --enable-pythoninterp=dynamic \
  # --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
  --enable-python3interp=yes \
  --with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu \
  --enable-cscope \
  --enable-gui=auto \
  #--enable-luainterp \
  #--with-luajit \
  --with-features=huge \
  --with-x \
  --enable-fontset \
  --enable-largefile \
  --disable-netbeans \
  --with-compiledby=sh1r0 \
  --enable-fail-if-missing && \
  make && make install

# RUN cd /usr/src                                                 \
#   && git clone https://gitee.com/mirrors/neovim.git            \
#   && cd neovim                                                  \
#   && make CMAKE_BUILD_TYPE=RelWithDebInfo                       \
#           CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=/usr/local" \
#   && make install                                               \
#   && rm -r /usr/src/neovim

RUN apt update && apt-get -y install software-properties-common 
RUN add-apt-repository ppa:neovim-ppa/unstable
RUN apt update && apt install -y python-dev python-pip python3-dev python3-setuptools python3-pip
RUN apt update && apt-get install -y neovim

RUN update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60 && \
      update-alternatives --set vi /usr/bin/nvim && \
      update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60 && \
      update-alternatives --config vim && \
      update-alternatives --set vim /usr/bin/nvim && \
      update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60 && \
      update-alternatives --set editor /usr/bin/nvim

RUN update-alternatives --install /usr/bin/python python /usr/bin/python2 0
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1
RUN update-alternatives --set python /usr/bin/python3
RUN apt clean && apt update && apt install python3-pip -y && apt clean

RUN apt update && apt install openjdk-8-jdk -y && apt clean
RUN apt-get update && apt-get install -y g++ build-essential cmake git libncurses-dev zlib1g-dev \
      libevent-dev \
      libcrypto++-dev libmsgpack-dev libjsoncpp-dev \
      libmysqlcppconn-dev libgtest-dev cmake libgoogle-perftools-dev \
      libssl-dev libmysqlclient-dev libcrypto++-dev libc6-dev libc6-dev-i386

COPY installNodejs.sh /
RUN chmod +x /installNodejs.sh && cd / && ./installNodejs.sh && ln -s /usr/bin/nodejs /usr/bin/node

RUN chown -R lxy /home/lxy/
USER lxy

WORKDIR $HOME
ENV PATH "/home/lxy/.local/bin:${PATH}"

COPY installCocvim.sh .
COPY vimrc ${HOME}/.vimrc
COPY coc-settings.json ${HOME}/.vim/
RUN sudo chmod +x installCocvim.sh && ./installCocvim.sh

USER root
#COPY installCcls.sh /
#COPY CMake /CMake
#COPY ccls /ccls
#RUN cd / && chmod +x installCcls.sh && ./installCcls.sh

RUN update-alternatives --set python /usr/bin/python2
