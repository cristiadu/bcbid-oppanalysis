#!/usr/bin/env bash

echo "============ BCBID OPPORTUNITY CSV PARSER: Configuring ============="
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac
echo "=> OS Type: ${machine}"
echo "===================================================================="

if [ "${machine}" == "Mac" ]; then
  brew install python3 && echo "=> Installed Python 3 and Pip 3"
  brew install wget && echo "=> Installed Wget"
  wget https://chromedriver.storage.googleapis.com/96.0.4664.18/chromedriver_mac64.zip && echo "=> Downloaded Chromedriver"
  unzip -d "${HOME}/.local/bin" chromedriver_mac64.zip && rm chromedriver_mac64.zip && echo "=> Unzipped Chromedriver on '${HOME}/.local/bin' folder."
else
  sudo apt-get install python3 python3-pip -y && echo "=> Installed Python 3 and Pip 3"
  wget https://chromedriver.storage.googleapis.com/96.0.4664.18/chromedriver_linux64.zip && echo "=> Downloaded Chromedriver"
  unzip -d "${HOME}/.local/bin" chromedriver_linux64.zip && rm chromedriver_linux64.zip && echo "=> Unzipped Chromedriver on '${HOME}/.local/bin' folder."
fi

pip3 install robotframework && echo "=> Installed Robot Framework"
pip3 install --upgrade robotframework-seleniumlibrary && echo "=> Installed Robot Framework Selenium Library"
export PATH="$PATH:${HOME}/.local/bin" && echo "=> Configured PATH variable on current Terminal session"
echo "===================================================================="
echo "====== BCBID OPPORTUNITY CSV PARSER: Configuration Completed! ======"
