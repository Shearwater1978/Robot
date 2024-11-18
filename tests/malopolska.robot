*** Settings ***
Library  Selenium2Library

*** Variables ***
${URL}              https://app.malopolska.uw.gov.pl/forms/Form/OkpWizard/1
${BROWSER}          Chrome
${OUTPUT_DIR}    /opt/screenshots

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

Rezerwacja Open web site
    Set Window Size	1900	1200
    Capture Page Screenshot     ${OUTPUT_DIR}/OkpWizard_opened.png    

Rezerwacja Fill all fields
    Sleep	2s
    Click Element	//*[@id="i_know_rodo_ki"]	
    Input Text	//*[@id="Imie"]	Jones
    Input Text	//*[@id="Nazwisko"]	Dow
    Input Text	//*[@id="DataUrodzenia"]	1900-01-01
    Input Text	//*[@id="NumerSprawy"]	12345.1900
    Capture Page Screenshot     ${OUTPUT_DIR}/OkpWizard_fill_name.png

Rezerwacja Check actual state
    Click Element	//*[@id="submit"]
    Sleep	10s
    Capture Page Screenshot	${OUTPUT_DIR}/OkpWizard_state.png
