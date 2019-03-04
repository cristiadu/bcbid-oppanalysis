# BCBID Opportunities Analysis
Parser and Analyzer for BCBID Opportunities (https://www.bcbid.gov.bc.ca)

## How to Run

### Usage pre-requirements

Execute the following commands in order to properly run the app:

```
sudo apt-get install python3 python3-pip -y
pip3 install robotframework
pip3 install --upgrade robotframework-seleniumlibrary
echo "export PATH='$PATH:/home/${USER}/.local/bin'" >> ~/.bashrc
wget https://chromedriver.storage.googleapis.com/73.0.3683.20/chromedriver_linux64.zip
unzip -d /home/${USER}/.local/bin chromedriver_linux64.zip && rm chromedriver_linux64.zip
```

If you're using another Terminal other than Bash, you'll need to do the last step on whichever file the terminal uses to add environmental variables.

### Running Parser

Execute the following `./startup.sh` script.

