#Project Description
**HireBright** is an app that helps to connect applicants with recruiters. As an applicant you can submit your application and see your application status, as a recruiter you have an access to data of all applicant, you can schedule and cancel interviews, search for applicants, see your upcomming and past interviews, see applicant GitHub profile, resume. It has pair programming tool that allows to ask code challenge and see other typing in a real time. The app also sends SMS when interview is scheduled.

#Setup
##Dependencies and Compatibility

**OSX** Install PostgreSQL. In the .bash_profile in your home directory, add the following line to the bottom of the file: export PATH=/Applications/Postgres.app/Contents/Versions/9.4/bin/:$PATH


##Installation
    Clone repository

    Create a virtual environment for the project 
    ```$ virtualenv env```

    Activate the environment 
    ```$ source env/bin/activate```

##Install requirements

    ```$ pip install -r requirements.txt```
    
    In order to access Twilio functionality, you should have twilio API keys and store them in secrets.sh file.

    Type in command line 
    ```source secrets.sh```
     for your app to have access to keys

    To be able to submit pdf files on "Submit Application" page, make sure your machine has 'pdftotext' or 'brew' it to you Mac.

    From the command line of the terminal, run 
    ```$ python server.py```

    In a browser window, type localhost:5000 to access the home page

##Testing
For testing use command line:
To run tests: 
``` coverage run tests.py ```
For report: 
``` coverage report -m tests.py ```

#Data

#Usage
#Tech Stack
Python, Flask, Socket, AJAX, JSON, HTML, CSS, PostgreSQL Full Text Search

#APIs Used
Twilio API
Github API

#Developer
**Alitsiya Yusupova** lives in San Francisco, CA. Check out her profile on [LinkedIn](https://www.linkedin.com/in/alitsiyayusupova).
