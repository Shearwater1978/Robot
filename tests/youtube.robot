*** Settings ***
Library  Selenium2Library

*** Variables ***
${URL}              http://www.youtube.com
${BROWSER}          Chrome
# Alternately https://accounts.lambdatest.com/profile you can also use xpath=//*[@id="tsf"]/div[2]/div/div[1]/div/div[1]/input
${element} 	    xpath=//*[@id="topbar"]/div[2]/div[2]/ytd-button-renderer/yt-button-shape/a/yt-touch-feedback-shape/div
${change_lng_login_form}   xpath=//*[@id="lang-chooser"]/div/div[1]

*** Test Cases ***
Open Chrome
    ${options}  Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()   sys
    Call Method     ${options}  add_argument    --start-maximized
    Create WebDriver    ${BROWSER}  chrome_options=${options}
    Go To   ${URL}

Youtube Open
    Maximize Browser Window
    Wait until page contains element  ${element}
    Capture Page Screenshot

Youtube Sign-in Click
    Click Element                       ${element}
    Wait until page contains element    ${change_lng_login_form}
    Capture Page Screenshot

Youtube Open Change Language
    Click Element                       xpath=(//*[@id="lang-chooser"])
    Capture Page Screenshot
