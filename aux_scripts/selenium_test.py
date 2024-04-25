import os

from selenium import webdriver
from selenium.webdriver.chrome.service import Service


service = Service(executable_path=r'/opt/chromedriver')
options = webdriver.ChromeOptions()
options.binary_location = '/opt/chrome/chrome'
options.add_argument('--no-sandbox')
options.add_argument('--disable-dev-shm-usage')
options.add_argument('--headless')
options.add_argument('--start-maximized')
options.add_argument('--user-data-dir=~/.config/google-chrome')


driver = webdriver.Chrome(service=service, options=options)


url = os.environ.get('TEST_URL', 'https://www.google.com')
driver.get(url)
driver.save_screenshot("/opt/screenshots/image.png")


driver.close()
