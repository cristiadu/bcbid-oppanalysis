*** Settings ***
Documentation     Keywords for File handling
Library           SeleniumLibrary
Library           OperatingSystem

*** Variables ***
${CSV_OPPORTUNITY_HEADERS}    "ID","Organization","Opportunity Name","Published Date","Closing Date","Details Link"

*** Keywords ***
Create CSV File With Opportunities Headers
    [Documentation]    Creates the CSV file needed for saving the parsed data. It creates with the data headers as the CSV file first elements.
    [Arguments]    ${file_path}
    Create File    ${file_path}
    File Should Exist    ${file_path}
    Append To File    ${file_path}    ${CSV_OPPORTUNITY_HEADERS}

Append Opportunity To File
    [Documentation]    Append that specific opportunity data into the CSV file created for it.
    [Arguments]    ${file_path}    ${opportunity_link}    ${opportunity_number}    ${opportunity_org}    ${opportunity_name}    ${opportunity_published}    ${opportunity_closing}
    Append To File    ${file_path}    ${\n}"${opportunity_number}","${opportunity_org}","${opportunity_name}","${opportunity_published}","${opportunity_closing}","${opportunity_link}"
