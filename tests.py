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

if __name__ == '__main__':
    # If called like a script, run our tests

    unittest.main()