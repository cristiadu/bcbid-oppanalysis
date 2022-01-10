*** Settings ***
Documentation     Parsing of BCBID Opportunities into a File
Library           SeleniumLibrary
Resource          keywords/bcbid.robot
Resource          keywords/files.robot

*** Variables ***
${CSV_PARSED_FILE}      parsed_opportunities.csv

*** Test Cases ***
Parse Opportunities Into File
    [Documentation]  Parse Opportunities into CSV file.
    [Setup]  Open BCBID Page

    ${num_pages}=  Calculate Number Of Pages Based On Records
    Log To Console  ${\n}TOTAL PAGES: ${num_pages}
    Create CSV File With Opportunities Headers  ${CSV_PARSED_FILE}

    FOR  ${page}  IN RANGE  1  ${num_pages}+1
      Open Opportunities Page  ${page}
      Fetch Opportunities Data From Page Into CSV File  ${CSV_PARSED_FILE}
      Log To Console  ${\n}Opportunities successfully parsed into CSV file: ${CSV_PARSED_FILE}
    END

    [Teardown]    Close Browser
    