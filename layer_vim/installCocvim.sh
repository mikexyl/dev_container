#!/bin/bash

sudo chown -R lxy ${HOME}

sudo apt update && sudo apt install exuberant-ctags -y && sudo apt clean

