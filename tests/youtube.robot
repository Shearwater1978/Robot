*** Settings ***
Library  Selenium2Library

*** Variables ***
${URL}              http://www.youtube.com
${BROWSER}          Chrome
${element} 	    xpath=//*[@id="topbar"]/div[2]/div[2]/ytd-button-renderer/yt-button-shape/a/yt-touch-feedback-shape/div
${change_lng_login_form}   xpath=//*[@id="lang-chooser"]/div/div[1]

*** Test Cases ***
Open Chrome
    ${options}  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys
    Call Method  ${options}  add_argument  --disable-notifications
    Call Method  ${options}  add_argument  --disable-infobars
    Call Method  ${options}  add_argument  --disable-extensions
    Call Method  ${options}  add_argument  --no-sandbox
    Call Method  ${options}  add_argument  --headless
    Call Method  ${options}  add_argument  --disable-dev-shm-usage
    Open Browser  ${URL}  Chrome  options=${options}
    Capture Page screenshot	./open_chrome.png
    Go To   ${URL}

Youtube Open
    Maximize Browser Window
    Wait until page contains element  ${element}
    Capture Page Screenshot	youtube_open.png

Youtube Sign-in Click
    Click Element                       ${element}
    Wait until page contains element    ${change_lng_login_form}
    Capture Page Screenshot

Youtube Open Change Language
    Click Element                       xpath=(//*[@id="lang-chooser"])
    Capture Page Screenshot