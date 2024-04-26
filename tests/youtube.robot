*** Settings ***
Library  Selenium2Library

*** Variables ***
${URL}              http://www.youtube.com
${BROWSER}          Chrome
${element} 	    xpath=//*[@id="topbar"]/div[2]/div[2]/ytd-button-renderer/yt-button-shape/a/yt-touch-feedback-shape/div
${change_lng_login_form}   xpath=//*[@id="lang-chooser"]/div/div[1]
${REJECTALL}    xpath=//*[@id="content"]/div[2]/div[6]/div[1]/ytd-button-renderer[1]/yt-button-shape/button/yt-touch-feedback-shape/div/div[2]
${OUPUT_PNG}    /opt/screenshots

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
    Capture Page Screenshot	${OUPUT_PNG}/open_chrome.png
    Go To   ${URL}
    Capture Page Screenshot	${OUPUT_PNG}/open_url.png

Youtube Open
    Set Window Size	1900	1200
    Wait until page contains element	//*[@id="cb-header"]/yt-formatted-string
    Click Element	${REJECTALL}
    Capture Page Screenshot	${OUPUT_PNG}/youtube_open.png