*** Settings ***
Documentation     Keywords to get Elements from BCBID Website
Library           SeleniumLibrary
Library           String
Resource          files.robot

*** Variables ***
${TOTAL_RECORDS_XPATH}                       (//table//span[contains(@class,'boldText') and contains(text(),'/')])[1]
${FORMAT_TOTAL_RECORDS_VALUE_REGEX}          .+\\s/\\s
${PAGE_IS_LOADED_CHECK_ELEMENT}              //a[contains(@class,'searchResultsBodyLink')]

${ALL_OPPORTUNITIES_XPATH}                   //td[@height="100"]/table[1]/tbody/tr[4]/td/table/tbody/tr
${SINGLE_OPPORTUNITY_XPATH}                  //td[@height="100"]/table[1]/tbody/tr[4]/td/table/tbody/tr[{}]

${OPPORTUNITY_LINK_ELEMENT}                  ${SINGLE_OPPORTUNITY_XPATH}//a[contains(@class,'searchResultsBodyLink')]
${OPPORTUNITY_LINK_ATTRIBUTE}                href
${SEPARATOR_FOR_HREF_FROM_OPPORTUNITY_LINK}  &
${OPPORTUNITY_LINK_REPLACE_DIS_KEY}          disID=

${OPPORTUNITY_NUMBER_ELEMENT}                ${SINGLE_OPPORTUNITY_XPATH}//a[contains(@class,'searchResultsBodyLink')]
${OPPORTUNITY_ORG_ELEMENT}                   ${SINGLE_OPPORTUNITY_XPATH}/td[5]
${OPPORTUNITY_NAME_ELEMENT}                  ${SINGLE_OPPORTUNITY_XPATH}/td[5]
${OPPORTUNITY_PUBLISHED_DATE_ELEMENT}        ${SINGLE_OPPORTUNITY_XPATH}/td[7]
${OPPORTUNITY_CLOSING_DATE_ELEMENT}          ${SINGLE_OPPORTUNITY_XPATH}/td[9]

${OPPORTUNITY_DETAILS_PAGE}                  https://www.bcbid.gov.bc.ca/open.dll/showDisplayDocument?sessionID=868585460&docType=Tender&dis_version_nos=0&doc_search_by=Tend&docTypeQual=TN
${OPPORTUNITY_DETAILS_PAGE_ID_ON_REQUEST}    &disID={}

${PAGE_REQUEST_URL}                          https://www.bcbid.gov.bc.ca/open.dll/submitDocSearch
${PAGE_REQUEST_FIXED_PARAMS}                 ?doc_search_by=TendSimp&searchResult=True&isChanged=no&dllAnchor=allOpenOpportunities&productDisID=simpleAll&dllPage=open_tenders_basic_content.html
${PAGE_REQUEST_FIXED_PARAMS_2}               &dllAnchor_pageLevel=pageLevel&orgPoptID=-1&field_disID1=2947095&field_disID2=2947099&field_disID3=2947091&fieldCount=3&document_search_status=Active&sessionID=1458945598
${PAGE_REQUEST_FIXED_PARAMS_3}               &selected_org_active=All&search_DocType=All&search_DocTypeQual=All&document_search_status=Active&selected_org_active=All&search_DocType=All&search_DocTypeQual=All
${ANOTHER_PAGE_PARAMS}                       &recordNum={}&currentPage={}
${BROWSER}                                   Chrome

*** Keywords ***
Open BCBID Page
    [Documentation]  Open the browser on BCBID first opportunities page, this will be the starting page.

    ${request}=  Get Request For Page Of Opportunities  1
    Open Browser  ${request}  ${BROWSER}


Open Opportunities Page
    [Documentation]  Open a specific opportunities page, we use this for looping through all pages getting the data we want.
    [Arguments]  ${page}

    ${request}=  Get Request For Page Of Opportunities  ${page}
    Go To  ${request}
    Wait Until Element Is Visible  ${PAGE_IS_LOADED_CHECK_ELEMENT}


Get Request For Page Of Opportunities
    [Documentation]  Configure the specific URL for getting a BCBID opportunities of a specific page number.
    [Arguments]    ${page}

    ${from_record}=  Evaluate  (${page}-1)*30+1
    ${custom_params}=    Format String  ${ANOTHER_PAGE_PARAMS}  ${from_record}  ${page}
    ${request}=    Set Variable    ${PAGE_REQUEST_URL}${PAGE_REQUEST_FIXED_PARAMS}${PAGE_REQUEST_FIXED_PARAMS_2}${PAGE_REQUEST_FIXED_PARAMS_3}${custom_params}

    [Return]  ${request}


Calculate Number Of Pages Based On Records
    [Documentation]  From checking their website we see each page contains 30 records, so we can calculate the number of pages based on the total number of results.

    ${num_records}=  Get Total Of Records
    ${num_pages}=  Evaluate  math.ceil(${num_records}/30)  math

    [Return]  ${num_pages}


Get Total Of Records
    [Documentation]  Gets total number of records from Opportunities list page.

    ${total_records_element}=  Get Text  ${TOTAL_RECORDS_XPATH}
    ${num_records}=  Replace String Using Regexp  ${total_records_element}  ${FORMAT_TOTAL_RECORDS_VALUE_REGEX}  ${EMPTY}

    [Return]  ${num_records}


Get Total Number Of Opportunities On Page
    [Documentation]  Returns the number of opportunities on the page based by a specific Xpath and expression evaluation.

    ${total_matching_xpath}=  Get Element Count  ${ALL_OPPORTUNITIES_XPATH}
    ${total_opportunities_on_page}=  Evaluate  ${total_matching_xpath}/7

    [Return]  ${total_opportunities_on_page}


Fetch Opportunities Data From Page Into CSV File
    [Documentation]  Iteration needed to get all the listed opportunities on a given BCBID Opportunities page, it also saves into the CSV file.
    [Arguments]  ${file_path}

    ${total_opportunities_on_page}=  Get Total Number Of Opportunities On Page
    FOR  ${index}  IN RANGE  1  ${total_opportunities_on_page}+1
      Append Opportunity Data Into CSV File  ${index}  ${file_path}
    END


Append Opportunity Data Into CSV File
    [Documentation]  Gets all the data we want from a specific opportunity listed on the page.
    [Arguments]  ${index}  ${file_path}

    ${opportunity_link}=  Get Opportunity Link From Index  ${index}
    ${opportunity_number}=  Get Opportunity Number From Index  ${index}
    ${opportunity_org}=  Get Opportunity Organization From Index  ${index}
    ${opportunity_name}=  Get Opportunity Name From Index  ${index}
    ${opportunity_published}=  Get Opportunity Published Date From Index  ${index}
    ${opportunity_closing}=  Get Opportunity Closing Date From Index  ${index}

    Append Opportunity To File  ${file_path}  ${opportunity_link}  ${opportunity_number}  ${opportunity_org}  ${opportunity_name}  ${opportunity_published}  ${opportunity_closing}


Get Specific Opportunity First Row Index
    [Documentation]  The website isn't very good at having individual identifiers, so we have to use a function to get the proper row from the element we want.
    [Arguments]  ${index}

    ${proper_index}=  Evaluate  7*(${index}-1)+3

    [Return]  ${proper_index}


Get Specific Opportunity Second Row Index
    [Documentation]  The website isn't very good at having individual identifiers, so we have to use a function to get the proper row from the element we want.
    [Arguments]  ${index}

    ${proper_index}=  Evaluate  7*(${index}-1)+4

    [Return]  ${proper_index}


Get Opportunity Link From Index
    [Documentation]  Gets, using XPath, the link from the opportunity on that specific index. It constructs the link dynamically using the JS on the href attribute.
    [Arguments]  ${index}

    ${element_index}=  Get Specific Opportunity First Row Index  ${index}
    ${exact_element}=  Format String  ${OPPORTUNITY_LINK_ELEMENT}  ${element_index}
    ${element_count}=  Get Element Count  ${exact_element}
    ${value_from_href}=  Run Keyword If  ${element_count}>0  Get Element Attribute  ${exact_element}  ${OPPORTUNITY_LINK_ATTRIBUTE}  ELSE  Set Variable  WITHDRAWN
    ${opportunity_final_url}=  Run Keyword If  "${value_from_href}"!="WITHDRAWN"  Get Formatted Opportunity Details URL  ${value_from_href}  ELSE  Set Variable  WITHDRAWN

    [Return]  ${opportunity_final_url}


Get Formatted Opportunity Details URL
    [Documentation]  Formats the specific Opportunity URL from provided value of the opportunity link href field. This is done to get the opportunity ID (disID) to construct the URL.
    [Arguments]  ${value_from_href}

    ${opp_link_split}=  Split String  ${value_from_href}  ${SEPARATOR_FOR_HREF_FROM_OPPORTUNITY_LINK}  2
    ${opportunity_link_id}=  Replace String  @{opp_link_split}[1]  ${OPPORTUNITY_LINK_REPLACE_DIS_KEY}  ${EMPTY}
    ${opportunity_final_url}=  Format String  ${OPPORTUNITY_DETAILS_PAGE}${OPPORTUNITY_DETAILS_PAGE_ID_ON_REQUEST}  ${opportunity_link_id}

    [Return]  ${opportunity_final_url}

Get Opportunity Number From Index
    [Documentation]  Gets, using XPath, the "number" value from the opportunity on that specific index.
    [Arguments]  ${index}

    ${element_index}=  Get Specific Opportunity First Row Index  ${index}
    ${exact_element}=  Format String  ${OPPORTUNITY_NUMBER_ELEMENT}  ${element_index}
    ${element_count}=  Get Element Count  ${exact_element}
    ${text_from_field}=  Run Keyword If  ${element_count}>0  Get Text  ${exact_element}  ELSE  Set Variable  WITHDRAWN

    [Return]  ${text_from_field}


Get Opportunity Organization From Index
    [Documentation]  Gets, using XPath, the "organization" value from the opportunity on that specific index.
    [Arguments]  ${index}

    ${element_index}=  Get Specific Opportunity First Row Index  ${index}
    ${exact_element}=  Format String  ${OPPORTUNITY_ORG_ELEMENT}  ${element_index}
    ${text_from_field}=  Get Text  ${exact_element}

    [Return]  ${text_from_field}


Get Opportunity Name From Index
    [Documentation]  Gets, using XPath, the "name" value from the opportunity on that specific index.
    [Arguments]  ${index}

    ${element_index}=  Get Specific Opportunity Second Row Index  ${index}
    ${exact_element}=  Format String  ${OPPORTUNITY_NAME_ELEMENT}  ${element_index}
    ${text_from_field}=  Get Text  ${exact_element}

    [Return]  ${text_from_field}


Get Opportunity Published Date From Index
    [Documentation]  Gets, using XPath, the "published_date" value from the opportunity on that specific index.
    [Arguments]  ${index}

    ${element_index}=  Get Specific Opportunity First Row Index  ${index}
    ${exact_element}=  Format String  ${OPPORTUNITY_PUBLISHED_DATE_ELEMENT}  ${element_index}
    ${text_from_field}=  Get Text  ${exact_element}

    [Return]  ${text_from_field}


Get Opportunity Closing Date From Index
    [Documentation]  Gets, using XPath, the "closing_date" value from the opportunity on that specific index.
    [Arguments]  ${index}

    ${element_index}=  Get Specific Opportunity First Row Index  ${index}
    ${exact_element}=  Format String  ${OPPORTUNITY_CLOSING_DATE_ELEMENT}  ${element_index}
    ${text_from_field}=  Get Text  ${exact_element}

    [Return]  ${text_from_field}