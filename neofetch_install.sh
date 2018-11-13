#!/bin/bash

cd ~/repos
git clone https://github.com/dylanaraps/neofetch.git
cd neofetch
git checkout 5.0.0
make install
