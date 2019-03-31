*** Settings ***
Documentation     Keywords to get Elements from BCBID Website
Library           SeleniumLibrary
Library           String

*** Variables ***
${PAGE_REQUEST_URL}                 https://www.bcbid.gov.bc.ca/open.dll/submitDocSearch
${PAGE_REQUEST_FIXED_PARAMS}        ?doc_search_by=TendSimp&searchResult=True&isChanged=no&dllAnchor=allOpenOpportunities&productDisID=simpleAll&dllPage=open_tenders_basic_content.html
${PAGE_REQUEST_FIXED_PARAMS_2}      &dllAnchor_pageLevel=pageLevel&orgPoptID=-1&field_disID1=2947095&field_disID2=2947099&field_disID3=2947091&fieldCount=3&document_search_status=Active&sessionID=1458945598
${PAGE_REQUEST_FIXED_PARAMS_3}      &selected_org_active=All&search_DocType=All&search_DocTypeQual=All&document_search_status=Active&selected_org_active=All&search_DocType=All&search_DocTypeQual=All
${ANOTHER_PAGE_PARAMS}              &recordNum={}&currentPage={}
${BROWSER}                         Chrome

*** Keywords ***
Open BCBID First Page Of Opportunities
    [Documentation]  Open the browser on the first opportunities page from BCBID list, this will be the starting page.

    ${request}=  Get Request For Page Of Opportunities  1
    Open Browser  ${request}  ${BROWSER}
    #Wait Until Element Is Visible  ${INITIAL_PAGE_ELEMENT}

Change Page
    [Arguments]  ${page}

    ${request}=  Get Request For Page Of Opportunities  ${page}
    Go To  ${request}


Get Request For Page Of Opportunities
    [Arguments]    ${page}

    ${from_record}=  Evaluate  (${page}-1)*30+1
    ${custom_params}=    Format String  ${ANOTHER_PAGE_PARAMS}  ${from_record}  ${page}
    ${request}=    Set Variable    ${PAGE_REQUEST_URL}${PAGE_REQUEST_FIXED_PARAMS}${PAGE_REQUEST_FIXED_PARAMS_2}${PAGE_REQUEST_FIXED_PARAMS_3}${custom_params}
    Log  ${request}
    [Return]  ${request}