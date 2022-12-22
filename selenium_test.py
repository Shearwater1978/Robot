from selenium import webdriver
from selenium.webdriver import DesiredCapabilities

options = webdriver.ChromeOptions()
options.binary_location = '/opt/chrome/chrome'
options.add_argument('--no-sandbox')
options.add_argument('--disable-dev-shm-usage')

driver = webdriver.Chrome('/opt/chromedriver',chrome_options=options)

driver.get('https://www.google.com/')

driver.close();
driver.quit();
