#!/usr/bin/env bash

sudo apt-get install python3 python3-pip -y
pip3 install robotframework
pip3 install --upgrade robotframework-seleniumlibrary
echo "export PATH='$PATH:/home/${USER}/.local/bin'" >> ~/.bashrc
wget https://chromedriver.storage.googleapis.com/73.0.3683.20/chromedriver_linux64.zip
unzip -d /home/${USER}/.local/bin chromedriver_linux64.zip && rm chromedriver_linux64.zip