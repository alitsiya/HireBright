#Project Description
**HireBright** is an app that helps to connect applicants with recruiters. As an applicant you can submit your application and txt or pdf resume and see your application status, as a recruiter you have an access to data of all applicant, you can schedule and cancel interviews, search for applicants and see results ordered by relevancy, see your upcomming and past interviews, see applicant GitHub profile, resume. It has pair programming tool to solve code challenges remotely in a real time. The app also sends SMS when interview is scheduled via Twilio API.

#Setup
##Dependencies and Compatibility

**OSX** Install PostgreSQL.

Use Sublime to edit the file in your home directory named .bash_profile:

``` $ subl ~/.bash_profile ``` 

Then, at the bottom of this file, add the following line (exactly):

``` export PATH=/Applications/Postgres.app/Contents/Versions/9.4/bin/:$PATH ``` 


##Installation
    Clone repository

    Create a virtual environment for the project 
    ``` $ virtualenv env ```

    Activate the environment 
    ``` $ source env/bin/activate ```

##Install requirements

    ``` $ pip install -r requirements.txt ```
    
    In order to access Twilio functionality, you should have twilio API keys and store them in secrets.sh file.

    Type in command line ``` source secrets.sh ``` for your app to have access to keys

    To be able to submit pdf files on "Submit Application" page, make sure your machine has 'pdftotext' or 'brew' it to you Mac.

    To run the app from the command line of the terminal, run 
    ``` $ python server.py ```
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
Python, Flask, Socket, JavaScript, AJAX/JSON, HTML, CSS, SQLAlchemy, PostgreSQL Full Text Search, Bootstrap

#APIs Used
Twilio API
Github API

#Developer
**Alitsiya Yusupova** lives in San Francisco, CA. Check out her profile on [LinkedIn](https://www.linkedin.com/in/alitsiyayusupova).
