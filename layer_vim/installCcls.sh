#!/bin/bash
sudo apt install rapidjson-dev -y
cd /ccls && cmake -H. -BRelease -DCMAKE_PREFIX_PATH=/clang+llvm-11.0.1-x86_64-linux-gnu-ubuntu-16.04 && cmake --build Release && cmake --build Release --target install

