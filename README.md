#Project Description
**HireBright** is an app that helps to connect applicants with recruiters. As an applicant you can submit your application and txt or pdf of your resume and see your application status. As a recruiter you have access to data of all applicants, you can schedule and cancel interviews, search for applicants and see results ordered by relevancy, see your upcoming and past interviews, and see applicant GitHub profile and resume. It has a pair programming tool to solve code challenges remotely in real time. The app also sends an SMS when an interview is scheduled via Twilio API. Passwords stored encrypted using *bcrypt*.

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

Install requirements
``` $ pip install -r requirements.txt ```
    
To access Twilio functionality, you should have [twilio API keys](https://www.twilio.com/docs/api/rest/sending-messages) and store them in secrets.sh file.

Create database with the name 'interviewer', run model.py
``` python -i model.py ``` and type ```db.create_all()``` or ``` psql interviewer < database.sql ```

Type in command line ``` source secrets.sh ``` for your app to have access to keys

To be able to submit pdf files on "Submit Application" page, make sure your machine has 'pdftotext' or 'brew' it to you Mac, it's free.

To run the app from the command line of the terminal, run 
``` $ python server.py ```

In a browser window, type localhost:5000 to access the home page

##Testing
For testing use command line:
` coverage run tests.py `
For report: 
` coverage report -m server.py `

#Data
You can generate your own data for applicants and recruiters. Also you can seed database.sql file into database `psql interviewer < database.sql` .  

#Usage
App designed for two types of users: applicants and recruiters. 
+ To sign up as applicant you have to submit job application. After that you'll be redirected to "Your application" page. This page has interview status and link to remote pait programming tool if interview was scheduled. You can review you application and delete your profile from here. 
+ To sign up as recruiter use sign up page with a secret (for now it's a word 'secret'). You have access to all applicant profiles, you can schedule interview, access your upcomming interviews, search for candidates. 

![](/readme-files/demo.gif)
Applicant UI:
![alt text][readme-files/application.png]
![alt text][readme-files/status.png]
As recruiter UI:
![alt text][readme-files/applicants.png]
![alt text][readme-files/search.png]
![alt text][readme-files/interviews.png]
![alt text][readme-files/profile.png]


#Tech Stack
Python, Flask, Websockets, JavaScript, AJAX/JSON, HTML, CSS, SQLAlchemy, PostgreSQL Full Text Search, Bootstrap

#APIs Used
Twilio API
Github API

#Developer
**Alitsiya Yusupova** lives in San Francisco, CA. Check out her profile on [LinkedIn](https://www.linkedin.com/in/alitsiyayusupova).
