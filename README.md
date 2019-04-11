# BCBID Opportunities Analysis
Parser and Analyzer for BCBID Opportunities (https://www.bcbid.gov.bc.ca)

This application uses Robot Framework to navigate over the BCBID interface and saves all listed opportunities on a CSV file.

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

You can also use the helper script we provided, just execute `./configure.sh`

If you're using another Terminal other than Bash, you'll need to do the last step on whichever file the terminal uses to add environmental variables.

### Running Parser

Execute the following `./startup.sh` script.

### Checking Parsed Results

See file `parsed_opportunities.csv` file on the root folder of this application after running the parser.

PS: Any Opportunitiy that didn't have an ID is, currently, the withdrawn opportunities from the website. 
We also add those to the CSV file, but with a message specifying they're withdrawn and not valid anymore.
