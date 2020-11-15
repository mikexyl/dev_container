#!/bin/bash

unset http_proxy && unset https_proxy
cd /CMake && ./bootstrap && make -j12 && sudo make install

sudo apt update && sudo apt install libclang-8-dev -y && sudo apt clean
cd /ccls/third_party/rapidjson && mkdir build && cd build && cmake .. && make -j12 && sudo  make install
cd /ccls && mkdir build && cd build && cmake .. && make -j12 && sudo  make install
