You should have twilio API keys which stored in secrets.sh file.

command source secrets.sh to have access to keys

To be able to submit pdf files on "Submit Application" page, make sure your machine has 'pdftotext' or 'brew' it to you Mac.

Testing:
For testing use command line:
To run tests: coverage run tests.py
For repost: coverage report -m my_program.py