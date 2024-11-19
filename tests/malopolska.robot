*** Settings ***
Library	Selenium2Library
Library	OperatingSystem

*** Variables ***
${URL}              https://app.malopolska.uw.gov.pl/forms/Form/OkpWizard/1
${BROWSER}          Chrome
${screenshotsFolder}    ${CURDIR}/screenshots
${JSON_PATH}	/opt/
${TIMEOUT}      10
${LOCATOR_NAME}	search-input
${testsRootFolder}	${CURDIR}
${inputDataFolder}	${CURDIR}
${inputDataEnv}=    %{MYDATA}

*** Test Cases ***
Read env
    Log To Console  ${inputDataEnv}

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
    Capture Page Screenshot     ${screenshotsFolder}/OkpWizard_opened.png

Rezerwacja Fill all fields
    ${content}	Evaluate	json.loads('''${inputDataEnv}''')	json
    Sleep	2s
    Click Element	//*[@id="i_know_rodo_ki"]
    Input Text	//*[@id="Imie"]	${content["Imie"]}
    Input Text	//*[@id="Nazwisko"]	${content["Nazwisko"]}
    Input Text	//*[@id="DataUrodzenia"]	${content["DataUrodzenia"]}
    Input Text	//*[@id="NumerSprawy"]	${content["NumerSprawy"]}
    Capture Page Screenshot     ${screenshotsFolder}/OkpWizard_fill_name.png

Rezerwacja Check actual state
    Click Element	//*[@id="submit"]
    Sleep	10s
    Capture Page Screenshot	${screenshotsFolder}/OkpWizard_state.png

Rezerwacja Validate results
   ${locator}=	Set Variable	xpath=//*[@id="Form.Okp"]/div[2]/div
   ${current text}=	Get Text	${locator}
   Should Not Contain	${current text}	Brak karty pobytu do odbioru
   Should Not Contain	${current text}	niewłaściwy format numeru sprawy
