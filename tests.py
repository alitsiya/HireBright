import unittest
from server import app, create_url, session, get_user_github_profile

class FlaskTests(unittest.TestCase):

    def setUp(self):
        self.client = app.test_client()
        app.config['TESTING'] = True

    # def tearDown(self):

    def test_create_url(self):
        # tests function that generates random url of length 10
        result = create_url()
        self.assertEqual(len(result), 10)

    def test_home(self):
        # integration tests
        result = self.client.get('/')
        self.assertEqual(result.status_code, 200)
        self.assertIn('text/html', result.headers['Content-Type'])
        self.assertIn('<h1>Welcome to HireBright</h1>', result.data)

    def test_data(self):
        """if no cookies should return 302"""
        result = self.client.get('/data')
        self.assertEqual(result.status_code, 302)

    def test_signin(self):
        result = self.client.get('/signin')
        self.assertEqual(result.status_code, 200)

    def test_data_session(self):
        """tests access to /data witout session"""
        with app.test_client() as c:
            result = c.get('/data')
            assert session.get('user_type') is None

    def test_submit_app(self):
        """test status code for /submit-application"""

        result = self.client.get('/submit-application')
        self.assertEqual(result.status_code, 200)

    def test_github_json(self):
        """Test that checks if GitHub API returns data for existing user"""

        result = get_user_github_profile('alitsiya')
        self.assertEqual(result['name'], "Alitsiya Yusupova")


from selenium import webdriver
from time import sleep
class TestSubmitForm(unittest.TestCase):

    def setUp(self):
        self.browser = webdriver.Firefox()

    def test_submission_form(self):
        self.browser.get('http://localhost:5000')
        sleep(5)
        self.browser.get('http://localhost:5000/submit-application')
        assert self.browser.title == 'HireBright - Submit your application'
        x = self.browser.find_element_by_name('first_name')
        x.send_keys("Alitsiya")
        y = self.browser.find_element_by_name('last_name')
        y.send_keys("Yusupova")
        y = self.browser.find_element_by_name('email')
        y.send_keys("ay@somedomain.com")
        p = self.browser.find_element_by_name('password')
        p.send_keys("qwerty")
        t = self.browser.find_element_by_name('phone')
        t.send_keys("+14252143104")
        l = self.browser.find_element_by_name('location')
        l.send_keys("San Francisco, CA")
        ln = self.browser.find_element_by_name('linkedin')
        ln.send_keys("alitsiyayusupova")
        ps = self.browser.find_element_by_name('position')
        ps.send_keys("Software Engineer")
        g = self.browser.find_element_by_name('github')
        g.send_keys("alitsiya")
        f = self.browser.find_element_by_name('file')
        f.send_keys("~/HackBright/project/files/jay_smith.txt")


if __name__ == '__main__':
    # If called like a script, run our tests

    unittest.main()