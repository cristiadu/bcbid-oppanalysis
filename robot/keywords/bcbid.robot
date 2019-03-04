*** Settings ***
Documentation     Keywords to get Elements from BCBID Website
Library           SeleniumLibrary

*** Variables ***
${INITIAL_URL}                     https://www.bcbid.gov.bc.ca/open.dll/showDocumentSearch?doc_search_by=TendSimp&catalogueType=SystemCatalogue&BypassCookie=yes&sessionID=932336139
${INITIAL_PAGE_ELEMENT}            css=.pageTitle
${JAVASCRIPT_ACTION_SEE_OPP_LIST}  showWorking(); setValueByName('productDisID', 'simpleAll'); setValueByName('dllAnchor', 'allOpenOpportunities'); setValueByName('productDesc', 'Browse All Open Opportunities');document.forms[0].submit()
${LIST_OPP_PAGE_ELEMENT}           css=.searchResultsHeader
${BROWSER}                         Chrome

*** Keywords ***
Open BCBID Opportunities Website
    [Documentation]  Open the browser on the opportunities page from BCBID, this will be the starting page.

    Open Browser    ${INITIAL_URL}    ${BROWSER}
    Wait Until Element Is Visible  ${INITIAL_PAGE_ELEMENT}

Show List Of Opportunities
    [Documentation]  Series of Javascript actions that will be executed to show the opportunities list.

    Execute Javascript  ${JAVASCRIPT_ACTION_SEE_OPP_LIST}
    Wait Until Element Is Visible  ${LIST_OPP_PAGE_ELEMENT}


Input Username
    [Arguments]    ${username}
    Input Text    username_field    ${username}