*** Settings ***
Library  Selenium2Library

*** Variables ***
${URL}              http://www.youtube.com
${BROWSER}          Chrome
${REJECTALL}	xpath=//*[@id="content"]/div[2]/div[6]/div[1]/ytd-button-renderer[1]/yt-button-shape/button
${OUTPUT_DIR}    /opt/screenshots
${TIMEOUT}      10
${LOCATOR_NAME}	search-input

*** Test Cases ***
Open Chrome
    ${options}  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys
    Call Method  ${options}  add_argument  --disable-notifications
    Call Method  ${options}  add_argument  --disable-infobars
    Call Method  ${options}  add_argument  --disable-extensions
    Call Method  ${options}  add_argument  --no-sandbox
    Call Method  ${options}  add_argument  --headless
    Call Method  ${options}  add_argument  --disable-dev-shm-usage
    Call Method  ${options}  add_argument  --start-maximized
    Open Browser  ${URL}  ${BROWSER}   options=${options}
    Go To   ${URL}

Youtube Open web site
    Set Window Size	1900	1200
    Wait until page contains element	//*[@id="cb-header"]/yt-formatted-string

Youtube Reject all cookies
    Go To   ${URL}
    Wait until page contains element	${REJECTALL}	${TIMEOUT}
    Set Focus To Element	${REJECTALL}
    Click Element	 ${REJECTALL}

Youtube Input some text in Search textbox
    Sleep	2s
    ${found1}=  Get Element Attribute  xpath=//*[starts-with(@id, '${LOCATOR_NAME}')]	class
    Click Element	xpath=//*[starts-with(@id, '${LOCATOR_NAME}')]
    Capture Page Screenshot     ${OUTPUT_DIR}/input_text_click_${LOCATOR_NAME}.png
    Set Focus To Element	xpath=//*[starts-with(@id, '${LOCATOR_NAME}')]
    Capture Page Screenshot     ${OUTPUT_DIR}/input_text_setfocus_${LOCATOR_NAME}.png
    Execute Javascript    document.getElementById('${LOCATOR_NAME}').value="Your Text"
    Capture Page Screenshot     ${OUTPUT_DIR}/input_text_fill_${LOCATOR_NAME}.png
    Click Element    xpath=//*[starts-with(@id, 'search-icon-legacy')]
    ${foundSearch}=	Get Element Attribute	xpath=//*[starts-with(@id, 'search-icon-legacy')]	class
    ${found2}=  Get Element Attribute  xpath=//*[starts-with(@id, 'search-container')]       class
    Log To Console     Search class for ${LOCATOR_NAME}: ${Found1}
    Log To Console     Search class for search-container: ${Found2}
    Log To Console	Search button class: ${foundSearch}
    Capture Page Screenshot     ${OUTPUT_DIR}/input_text_input.png