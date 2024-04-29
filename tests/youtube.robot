*** Settings ***
Library  Selenium2Library

*** Variables ***
${URL}              http://www.youtube.com
${BROWSER}          Chrome
${REJECTALL}	xpath=//*[@id="content"]/div[2]/div[6]/div[1]/ytd-button-renderer[1]/yt-button-shape/button
${OUTPUT_DIR}    /opt/screenshots
${TIMEOUT}      10


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

Yotube Reject all cookies
    Go To   ${URL}
    Wait until page contains element	${REJECTALL}	${TIMEOUT}
    Set Focus To Element	${REJECTALL}
    Click Element	 ${REJECTALL}

Youtube Input some text in Search textbox
    Sleep	2s
    Click Element		xpath://*[@id="search-input"]
    Capture Page Screenshot     ${OUTPUT_DIR}/input_text_click.png
    Input Text			xpath://*[@id="search-container"]	AAAAA
    Capture Page Screenshot     ${OUTPUT_DIR}/input_text_input.png
#    Execute Javascript		document.querySelector("#search-icon-legacy > yt-icon > yt-icon-shape").click()
    Capture Page Screenshot	${OUTPUT_DIR}/input_text_last.png