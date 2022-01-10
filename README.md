# BCBID Opportunities Analysis
Parser and Analyzer for BCBID Opportunities (https://www.bcbid.gov.bc.ca)

This application uses Robot Framework to navigate over the BCBID interface and saves all listed opportunities on a CSV file.

## How to Run

### Usage pre-requirements

Execute the following commands in order to properly run the app:

```
./configure.sh
```

This works for both `MacOS` and `Linux` currently.

### Running Parser

Execute the `./startup.sh` script.

### Checking Parsed Results

See file `parsed_opportunities.csv` file on the root folder of this application after running the parser.

PS: Any Opportunitiy that didn't have an ID is, currently, the withdrawn opportunities from the website. 
We also add those to the CSV file, but with a message specifying they're withdrawn and not valid anymore.
