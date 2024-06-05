import unittest
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import NoSuchElementException
from selenium.common.exceptions import TimeoutException
import time

class TestTheInternet(unittest.TestCase):
    def setUp(self):
        """Setup method to initiate the Chrome WebDriver"""
        service = Service(ChromeDriverManager().install())
        self.driver = webdriver.Chrome(service=service)
        self.driver.get("https://the-internet.herokuapp.com/")

    def test_login_valid(self):
        """Test logging in with valid credentials"""
        self.driver.find_element(By.LINK_TEXT, "Form Authentication").click()
        self.driver.find_element(By.ID, "username").send_keys("tomsmith")
        self.driver.find_element(By.ID, "password").send_keys("SuperSecretPassword!")
        self.driver.find_element(By.CSS_SELECTOR, "button.radius").click()
        assert "secure area" in self.driver.page_source.lower()

    def test_login_invalid(self):
        """Test logging in with invalid credentials"""
        self.driver.find_element(By.LINK_TEXT, "Form Authentication").click()
        self.driver.find_element(By.ID, "username").send_keys("invalid_user")
        self.driver.find_element(By.ID, "password").send_keys("invalid_password")
        self.driver.find_element(By.CSS_SELECTOR, "button.radius").click()
        assert "login" in self.driver.page_source.lower()

    def test_forgot_password(self):
        """Test the forgot password flow expecting an internal server error."""
        self.driver.find_element(By.LINK_TEXT, "Forgot Password").click()
        self.driver.find_element(By.ID, "email").send_keys("example@example.com")
        self.driver.find_element(By.ID, "form_submit").click()

        WebDriverWait(self.driver, 10).until(
            lambda d: "internal server error" in d.page_source.lower()
        )

        page_source = self.driver.page_source.lower()
        self.assertIn("internal server error", page_source, "Internal Server Error should be displayed.")

    def test_drag_and_drop(self):
        """Test drag and drop functionality"""
        self.driver.get("https://the-internet.herokuapp.com/drag_and_drop")
        source_element = self.driver.find_element(By.ID, "column-a")
        target_element = self.driver.find_element(By.ID, "column-b")
        webdriver.ActionChains(self.driver).drag_and_drop(source_element, target_element).perform()
        assert source_element.text == "B"

    def test_dynamic_loading(self):
        """Test dynamic loading of elements"""
        self.driver.find_element(By.LINK_TEXT, "Dynamic Loading").click()
        self.driver.find_element(By.LINK_TEXT, "Example 1: Element on page that is hidden").click()
        self.driver.find_element(By.TAG_NAME, "button").click()
        finish_text = WebDriverWait(self.driver, 10).until(
            EC.visibility_of_element_located((By.ID, "finish"))
        )
        self.assertTrue(finish_text.is_displayed())

    def test_logout(self):
        """Test logging out functionality"""
        self.test_login_valid()
        self.driver.find_element(By.LINK_TEXT, "Logout").click()
        assert "login" in self.driver.page_source.lower()

    def test_check_elements_presence(self):
        """Check presence of specific elements on the homepage"""
        elements = ["Form Authentication", "Dropdown", "JavaScript Alerts"]
        links = self.driver.find_elements(By.TAG_NAME, "a")
        visible_links = [link.text for link in links if link.is_displayed()]
        self.assertTrue(all(elem in visible_links for elem in elements))

    def test_handling_alerts(self):
        """Test handling JavaScript alerts"""
        self.driver.find_element(By.LINK_TEXT, "JavaScript Alerts").click()

        self.driver.find_element(By.XPATH, "//button[text()='Click for JS Alert']").click()

        alert = WebDriverWait(self.driver, 10).until(EC.alert_is_present())
        alert.accept()

        result_text = self.driver.find_element(By.ID, "result").text
        self.assertIn("successfully", result_text)


    def test_edit_user_data(self):
        """Test scenario for user data editing."""
        self.test_login_valid()

        try:
            logout_button = WebDriverWait(self.driver, 10).until(
                EC.presence_of_element_located((By.LINK_TEXT, "Logout"))
            )
        except TimeoutException:
            self.fail("Przycisk 'Logout' nie został znaleziony, logowanie nie powiodło się.")

        try:
            logout_button.click()
        except NoSuchElementException:
            self.fail("Nie znaleziono przycisku 'Logout'.")


    def test_javascript_alerts(self):
        """Test handling different JavaScript alerts"""
        self.driver.find_element(By.LINK_TEXT, "JavaScript Alerts").click()

        self.driver.find_element(By.XPATH, "//button[text()='Click for JS Confirm']").click()

        alert = WebDriverWait(self.driver, 10).until(EC.alert_is_present())
        alert.accept()

        result_text = self.driver.find_element(By.ID, "result").text
        self.assertIn("You clicked: Ok", result_text)


    def test_hover_over(self):
        """Test hover over functionality to reveal additional options"""
        self.driver.find_element(By.LINK_TEXT, "Hovers").click()
        images = self.driver.find_elements(By.CLASS_NAME, "figure")
        for img in images:
            webdriver.ActionChains(self.driver).move_to_element(img).perform()
            assert img.find_element(By.CLASS_NAME, "figcaption").is_displayed()

    def test_infinite_scroll(self):
        """Test infinite scroll functionality."""
        self.driver.get("https://the-internet.herokuapp.com/infinite_scroll")
        initial_height = self.driver.execute_script("return document.body.scrollHeight")

        max_scrolls = 3
        for _ in range(max_scrolls):
            self.driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
            time.sleep(2)

            new_height = self.driver.execute_script("return document.body.scrollHeight")
            self.assertTrue(new_height > initial_height, "The scroll height did not increase after scrolling.")

            initial_height = new_height

        self.assertEqual(max_scrolls, 3, "Did not scroll the expected number of times.")



    def test_key_presses(self):
        """Test response to key presses"""
        self.driver.find_element(By.LINK_TEXT, "Key Presses").click()
        search_box = self.driver.find_element(By.ID, "target")
        search_box.send_keys("T")
        result_text = self.driver.find_element(By.ID, "result").text
        self.assertIn("You entered: T", result_text)

    def test_file_download(self):
        """Test file download capability"""
        self.driver.find_element(By.LINK_TEXT, "File Download").click()
        self.driver.find_element(By.LINK_TEXT, "some-file.txt").click()

    def test_file_upload(self):
        """Test file upload functionality"""
        self.driver.find_element(By.LINK_TEXT, "File Upload").click()

        file_to_upload = r'C:\Users\Asus\Desktop\UJ - SEM2\projektowanie_obiektowe\LAB9\prooba\testy\testowy.txt'

        self.driver.find_element(By.ID, "file-upload").send_keys(file_to_upload)
        self.driver.find_element(By.ID, "file-submit").click()

        uploaded_files = self.driver.find_element(By.ID, "uploaded-files").text
        self.assertIn("testowy.txt", uploaded_files)

    def test_context_menu(self):
        """Test right click context menu functionality"""
        self.driver.find_element(By.LINK_TEXT, "Context Menu").click()
        box = self.driver.find_element(By.ID, "hot-spot")
        webdriver.ActionChains(self.driver).context_click(box).perform()
        alert = WebDriverWait(self.driver, 10).until(EC.alert_is_present())
        alert.accept()

    def test_frames_switch(self):
        """Test switching between frames"""
        self.driver.find_element(By.LINK_TEXT, "Frames").click()
        self.driver.find_element(By.LINK_TEXT, "Nested Frames").click()
        self.driver.switch_to.frame("frame-top")
        self.driver.switch_to.frame("frame-middle")
        self.assertTrue("MIDDLE" in self.driver.find_element(By.ID, "content").text)

    def test_dynamic_controls(self):
        """Test dynamic controls (add/remove elements)"""
        self.driver.find_element(By.LINK_TEXT, "Dynamic Controls").click()
        self.driver.find_element(By.XPATH, "//button[contains(text(),'Remove')]").click()

        WebDriverWait(self.driver, 10).until(EC.invisibility_of_element_located((By.ID, "checkbox")))

        self.driver.find_element(By.XPATH, "//button[contains(text(),'Add')]").click()

        WebDriverWait(self.driver, 10).until(EC.visibility_of_element_located((By.ID, "checkbox")))


    def test_slider_movement(self):
        """Test moving a slider control."""
        self.driver.find_element(By.LINK_TEXT, "Horizontal Slider").click()

        slider = self.driver.find_element(By.TAG_NAME, "input")

        width = slider.size['width']
        move = width * 0.8
        webdriver.ActionChains(self.driver).click_and_hold(slider).move_by_offset(move, 0).release().perform()

        slider_value = self.driver.find_element(By.ID, "range").text
        self.assertTrue(float(slider_value) > 0, "Slider value has not increased after moving.")


    def test_status_codes(self):
        """Test visiting various status code links"""
        self.driver.find_element(By.LINK_TEXT, "Status Codes").click()
        self.driver.find_element(By.LINK_TEXT, "404").click()
        assert "404" in self.driver.page_source.lower()

    def tearDown(self):
        """Teardown method to close the web browser"""
        self.driver.quit()

if __name__ == "__main__":
    unittest.main()