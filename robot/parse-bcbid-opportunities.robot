*** Settings ***
Documentation     Parsing of BCBID Opportunities into a File
Library           SeleniumLibrary
Resource          keywords/bcbid.robot
Resource          keywords/files.robot

*** Test Cases ***
Parse Opportunities Into File
    Open BCBID First Page Of Opportunities
    Sleep  20s
    Change Page  2
    Sleep  20s
    [Teardown]    Close Browser