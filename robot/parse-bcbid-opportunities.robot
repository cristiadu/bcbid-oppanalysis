*** Settings ***
Documentation     Parsing of BCBID Opportunities into a File
Library           SeleniumLibrary
Resource          keywords/bcbid.robot
Resource          keywords/files.robot

*** Test Cases ***
Parse Opportunities Into File
    Open BCBID Opportunities Website
    Show List Of Opportunities
    [Teardown]    Close Browser