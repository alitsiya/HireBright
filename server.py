import string
from datetime import datetime
import os
import subprocess   #for running shell command for converting txt to pdf
import urllib2 #for dealing with github api
import json
from random import choice
from gevent import monkey; monkey.patch_all()
from flask import Flask, render_template, redirect, request, flash, session, jsonify
from flask_debugtoolbar import DebugToolbarExtension
from flask.ext.bcrypt import Bcrypt #for securing passwords
from twilio.rest import TwilioRestClient
import re #for escaping non ascii chars
from model import Recruiter, User, Resume, Tool, Opening, Status, Interview, connect_to_db, db

from socketio import socketio_manage
from socketio.namespace import BaseNamespace
from socketio.mixins import RoomsMixin, BroadcastMixin

# The socket.io namespace
class ChatNamespace(BaseNamespace, RoomsMixin, BroadcastMixin):

    def on_nickname(self, nickname):

        self.environ.setdefault('nicknames', []).append(nickname)
        self.socket.session['nickname'] = nickname
        self.broadcast_event('announcement', '%s has connected' % nickname)
        self.broadcast_event('nicknames', self.environ['nicknames'])
        # Just have them join a default-named room

        self.join('main_room')


    def on_user_message(self, msg):
        self.emit_to_room('main_room', 'msg_to_room', self.socket.session['nickname'], msg)


app = Flask(__name__)
bcrypt = Bcrypt(app)

app.secret_key = 'Shhhhhhhhh'


@app.route('/')
def index():
    """Homepage"""

    if session.get('user_type'):
        if session['user_type'] == 'user':
            return redirect('/view-status')
        else:
            return redirect('/data')
    else:
        return render_template("homepage.html")


@app.route('/signin', methods=['GET'])
def render_sign_in():
    """Render Sign In Page"""

    return render_template("sign-in.html")


@app.route('/signin', methods=['POST'])
def sign_in():
    """Dealing with Submit on Sign In Page"""

    email = request.form.get('email')
    password = request.form.get('password')

    # if user exist - log in and redirect to homepage
    existing_user = User.query.filter_by(email=email).first()
    existing_hr = Recruiter.query.filter_by(email=email).first()

    if not existing_hr and not existing_user:
    # if hr doesn't exist - add user to db  and redirect
        flash("You're not registered. Do you want to submit your application?")
        return redirect('/submit-application')
    else:
        if existing_hr:
            if not bcrypt.check_password_hash(existing_hr.password, password):
                flash("Incorrect password")

                return redirect("/signin")

            else:
                session['email'] = email
                session['user_type'] = 'recruiter'
                flash("Logged in as recruiter %s %s" % (existing_hr.first_name, existing_hr.last_name))

                return redirect("/data")

        if existing_user:
            if not bcrypt.check_password_hash(existing_user.password, password):
                flash("Incorrect password")

                return redirect("/signin")

            else:
                session['email'] = email
                session['user_type'] = 'user'
                flash("Logged in as applicant %s %s" % (existing_user.first_name, existing_user.last_name))

                return redirect("/view-status")


@app.route('/signup', methods=['GET'])
def sign_up_form():
    """Sign Up page"""

    return render_template("sign-up.html")


@app.route('/signup', methods=['POST'])
def sign_up():
    """Handles Sign Up page input"""

    email = request.form.get('email')
    password = request.form.get('password')
    pw_hash = bcrypt.generate_password_hash(password)
    first_name = request.form.get('first_name')
    last_name = request.form.get('last_name')
    title = request.form.get('title')
    phone = request.form.get('phone')
    secretkey = request.form.get('secretkey')

    if secretkey == 'secret':
        recruiter = Recruiter(
                    first_name=first_name,
                    last_name=last_name,
                    email=email,
                    password=pw_hash,
                    title=title,
                    phone=phone,
                    )
        db.session.add(recruiter)
        db.session.commit()
        print "\n Recruiter Added to Database \n"
        session['email'] = email
        session['user_type'] = 'recruiter'
        flash("%s %s has been signed up" % (first_name, last_name))
        return redirect("/data")
    else: 
        flash("Something went wrong")
        return redirect("/signup")


@app.route('/logout')
def sign_out():
    """Log out users"""

    if session:
        print session['email']
        print "\n\n\n\n", session['user_type']
        del session['email']
        del session['user_type']
        flash("The user has logged out")

    return redirect("/")


@app.route('/submit-application', methods=["GET"])
def application_render():
    """When user clicks to submit button, application goes to database"""

    return render_template('application.html')


@app.route('/submit-application', methods=["POST"])
def application_submit():
    """When user clicks to submit button, application goes to database and inserts
    user, resume, interview.
    It doesn't chack all fields' input for now.
    """

    email = request.form.get('email')
    password = request.form.get('password')
    pw_hash = bcrypt.generate_password_hash(password)
    first_name = request.form.get('first_name')
    last_name = request.form.get('last_name')
    location = request.form.get('location')
    phone = request.form.get('phone')
    linkedin = request.form.get('linkedin')
    github = request.form.get('github')
    position = request.form.get('position')
    salary = request.form.get('salary') or None
    text_file = request.files['file']

    #check if user already exists
    existing_user = User.query.filter(User.email == email).first()
    if existing_user:
        flash("User with that email already exists, use sign-in page to edit your application.")
        return redirect('/signin')

    #checks if there is an attached file
    if not text_file:
        flash('Some problems with your attachment')
        return redirect('/submit-application')

    #check if pdf or txt file was passed
    file_name = str(text_file.filename)

    if file_name.split('.')[1] == 'pdf':
        text_file.save('./files/RESUME.pdf')
        f = os.popen('pdftotext ./files/RESUME.pdf -')
        file_contents = f.read()
        print type(file_contents)
        file_contents = re.sub(r'[\x00-\x08\x0b\x0c\x0e-\x1f\x7f-\xff]', ' ', file_contents)
        file_contents = file_contents.replace('\n', '<br>')
        resume_text = file_contents.translate(None, string.punctuation)
        resume_text = resume_text.strip().lower().replace('brbr', ' ')

        print "\n\n\n PDF read SUCCESS"

    elif file_name.split('.')[1] == 'txt':
        #resume for display
        file_contents = text_file.stream.read().decode("utf-8")
        file_contents = file_contents.replace(u'\u2019', u'\'').encode('ascii', 'ignore')
        file_contents = file_contents.replace('\n', '<br>')

        #resume type for search
        resume_text = file_contents.translate(None, string.punctuation)
        resume_text = resume_text.strip().lower().replace('<br>', ' ')

        print "\n\n\n PDF read SUCCESS"

    else:
        flash('Some problems with your attachment')
        return redirect('/submit-application')

    #creating resume object
    resume = Resume(
                    resume_text=file_contents,
                    resume_string=resume_text,
                   )
    db.session.add(resume)
    print "\n Resume Added to Database \n"
    db.session.flush()
    db.session.commit()
    #creating user object
    user = User(
                    first_name=first_name,
                    last_name=last_name,
                    email=email,
                    password=pw_hash,
                    location=location,
                    position=position,
                    phone=phone,
                    linkedin=linkedin,
                    github=github,
                    resume_id=resume.resume_id,
                    salary=salary,
                    )
    db.session.add(user)
    print "\n User Added to Database \n"
    db.session.flush()
    #creating interview object with status_id 'New'
    status_name = Status.query.filter(Status.status_name == 'New').one()
    interview = Interview (
                        user_id=user.user_id,
                        status_id=status_name.status_id) 
    db.session.add(interview)
    print "\n Interview Added to Database \n"
    flash("Thank you for applying! You can review your information on status page")
    db.session.commit()

    text_file.close()
    if not session.get('email'):
        session['email'] = email
        session['user_type'] = 'user'

    return redirect('/')


@app.route('/delete-account', methods=["POST"])
def delete_user_account():
    """Delete user when on user profile page for demo"""

    email = session['email']

    print "\n\n", email
    user = User.query.filter_by(email=email).one()
    Interview.query.filter_by(user_id=user.user_id).delete()
    Resume.query.filter_by(resume_id=user.resume_id).delete()
    User.query.filter_by(email=email).delete()

    db.session.commit()
    del session['email']
    del session['user_type']
    flash("Your account was successfully deleted from database")
    return redirect('/')




@app.route('/view-status')
def render_view_status():
    """Renders view status page when user signed in
    
    Page for applicant to view submitted info and interview status 
    """

    if session.get('user_type') == 'user':
        print "\n\n\n\n", session.get('user_type')
        email = session['email']

        user = User.query.filter(User.email == email).first()
        if user:
            interview = Interview.query.filter(Interview.user_id==user.user_id).one()
            time_of_submission = user.time_of_submission.strftime('%Y-%m-%d %H:%M:%S')
            return render_template("status.html", user=user, interview=interview, time_of_submission=time_of_submission)
        else:
            flash("You are not logged in or logged in as a recruiter")
            return redirect("/")

    else:
        flash("You are not logged in or logged in as a recruiter")
        return redirect("/")
        


@app.route('/data')
def render_data():
    """Renders data page when recruiter signed in
    
    Shows list of applicants' names and interview status, also has links to individual applicant profile
    """

    if session.get('user_type') == 'recruiter':
        email = session['email']
        recruiter = Recruiter.query.filter(email == email).first()
        if recruiter:
            users = User.query.all()

            return render_template("data.html", users=users)
        else:
            flash("You don't have permissions to view content")
            return redirect("/")
    else:
        flash("You are not logged in")
        return redirect("/")


def get_user_github_profile(user_login):
    d = None
    try:
        req = urllib2.Request('https://api.github.com/users/'+user_login, None, {"Authorization": 'token '+os.environ['GITHUB_AUTH_TOKEN']})
        github_data = urllib2.urlopen(req).read()
        json_acceptable_string = github_data.replace("'", "\"")

        d = json.loads(json_acceptable_string)
        return d
    except IOError as e:
        print "I/O error({0}): {1}".format(e.errno, e.strerror)
    except ValueError:
        print "Could not convert data to a dictionary"
    except:
        print "Unexpected error:"
        raise


@app.route('/users/<int:user_id>')
def show_user_data(user_id):
    """Shows data for particular user
    
    Renders page with info about user, his/her github profile data if GitHub nickname provided
    """

    if session.get('user_type') == 'recruiter':
        email = session['email']
        recruiter = Recruiter.query.filter(email == email).first()
        if recruiter:
            user = User.query.get(user_id)
            interview = Interview.query.filter(Interview.user_id==user.user_id).first()
            recruiters = Recruiter.query.all()

            d = get_user_github_profile(user.github)

            return render_template("user.html", user=user, interview=interview, recruiters=recruiters, github_data=d)
        else:
            flash("You don't have permissions to view a content")
            return redirect("/")
    else:
        flash("You are not logged in")
        return redirect("/")


# helper function that creates random url for pair programming tool
def create_url():
    s = string.letters + string.digits
    url = ''
    for i in range(10):
        url += choice(s)
    return url


@app.route('/schedule_interview', methods=["POST"])
def put_interview_db():
    """When on page users/<int> 'Schedule interview' form submitts it sends ajax call that
        updates user interview table in db.  

    Allows to schedule or cancel interview depending on interview status,
    Sends sms to phonenumber via Twilio API when interview is scheduled
    """

    date = request.json['interview_date']    #01/29/2016 format
    time = request.json['interview_hour']    #10, 12, 14 format
    recrcuiter_id = request.json['recrcuiter_id']
    user_email = request.json['user_email']

    #convert date and time to datetime object
    date_object = datetime.strptime(date + ' ' + time, '%m/%d/%Y %H')

    user = User.query.filter(User.email==user_email).first()

    interview = Interview.query.filter(Interview.user_id==user.user_id).first()

    status = Status.query.filter(Status.status_name=="Phone Interview").one()

    if not interview.link_id:
        url = create_url()
        tool = Tool( link=url)
        db.session.add(tool)
        db.session.flush()
        interview.link_id = tool.link_id

    interview.interview_date = date_object
    interview.recruiter_id = recrcuiter_id
    interview.status_id = status.status_id

    db.session.add(interview)
    db.session.commit()

    #send sms to user phone
    account_sid = os.environ['TWILIO_ACCOUNT_SID']
    auth_token = os.environ['TWILIO_AUTH_TOKEN']
    client = TwilioRestClient(account_sid, auth_token)
    user_phone = user.phone

    message = client.messages.create(to=user_phone, from_=os.environ['TWILIO_NUMBER'],
                                     body="%s, your interview with HireBright scheduled on %s " % (user.first_name, str(date_object)),
                                     )

    print '\n\n\nSuccesss!!!\n\n\n'
    return "Interview was scheduled successfully!"


@app.route('/cancel-interview', methods=['POST'])
def cancel_interview():
    """When button cancel interview submited it updates db"""

    data = int(request.json['user_id'])
    interview = Interview.query.filter_by(user_id=data).one()

    # updating interview fields
    interview.interview_date = None
    interview.recruiter_id = None
    interview.status_id = 1 #this should have more logic, if I will have time
    db.session.add(interview)
    db.session.commit()
    print "\n\n\n Interview for user_id", data, "was canceled"
    return "Success"


@app.route('/search')
def render_search():
    """Render search page"""

    if session.get('user_type') == 'recruiter':
        return render_template('search.html')
    else:
        return redirect('/')


@app.route('/search', methods=['POST'])
def search():
    """Search using inverted index for keywords

    When user search for keywords on search page it makes ajax call with a keywords in it. 
    This makes a query to resume_string colomn and converts it to inverted index by 
    built in method to_tsvector and returns resume_id and rank of the document.
    """

    #take data from ajax request and split it to multiply queries
    search_query = request.json['search_query'].lower().split(' ')
    query = ''
    for i in range(len(search_query)):
        if i < len(search_query) - 1:
            query = query + search_query[i] + ' | '
        else:
            query = query + search_query[i]

    # query that returns id and rank, see page http://rachbelaid.com/postgres-full-text-search-is-good-enough/
    QUERY = """SELECT resume_id, (SELECT ts_rank(to_tsvector(resume_string), to_tsquery((:query)))) AS relevancy FROM resumes ORDER BY relevancy DESC
            """
    # query for snippet with max fragment length 3, http://www.postgresql.org/docs/9.1/static/textsearch-controls.html
    QUERY_SNIPPET = """SELECT ts_headline('english', (:text), to_tsquery((:query)), 'MaxWords=30, MinWords=5, ShortWord=3, HighlightAll=FALSE, MaxFragments=3, FragmentDelimiter=" ... " ' )"""
    
    cursor = db.session.execute(QUERY, {'query': query})
    results = cursor.fetchall()

    res_dict = {}
    for result in results:
        if result[1] > 0.001:
            resume = Resume.query.get(result[0])

            if resume.user:
                r_text = resume.resume_text
                cursor = db.session.execute(QUERY_SNIPPET, {'query': query, 'text': r_text})
                snippet = cursor.fetchall()
                res = ''
                for item in snippet:
                    res += str(item[0])

                res_dict[resume.user[0].user_id] = {'snippet': str(res), 'resume': resume.resume_text, 'user': resume.user[0].first_name + ' ' + resume.user[0].last_name, 'email': resume.user[0].email, 'relevancy': result[1]}

    return jsonify(res_dict)


@app.route('/interviews')
def show_interviews():
    """Renders page with scheduled interviews for particular recruiter if he/she logged in"""

    if session:
        email = session.get('email')
        print "\n\n\n", email
        recruiter = Recruiter.query.filter(Recruiter.email==email).first()
        if recruiter:
            print "\n\n\n Recruiter id", recruiter.recruiter_id
            interviews = Interview.query.filter_by(recruiter_id=recruiter.recruiter_id).all()
            print "\n\n\n", interviews
            if interviews:
                return render_template('interviews.html', interviews=interviews)
            else:
                flash('You don\'t have anything scheduled')
                return redirect('/data')
        else:
            flash('You are not registred or don\'t have permissions to view data')
            return redirect('/')


@app.route('/tool/<path>')
def render_tool(path):
    """Renders pair programming tool """

    return render_template('test-tool.html')


@app.route("/socket.io/<path:path>")
def run_socketio(path):
    """Makes socket connection for particular namespace """

    socketio_manage(request.environ, {'': ChatNamespace})


if __name__ == "__main__":

    # We have to set debug=True here, since it has to be True at the point
    # that we invoke the DebugToolbarExtension
    # app.debug = True
    DebugToolbarExtension(app)

    connect_to_db(app)

    # app.run()
    PORT = int(os.environ.get("PORT", 5000))

    # app.run(debug=True, host="0.0.0.0", port=PORT)
    print 'Listening on http://localhost:5000'
    app.debug = True
    import os
    from werkzeug.wsgi import SharedDataMiddleware
    app = SharedDataMiddleware(app, {
        '/': os.path.join(os.path.dirname(__file__), 'static')
        })
    from socketio.server import SocketIOServer
    SocketIOServer(('0.0.0.0', port=PORT), app,
        resource="socket.io", policy_server=False).serve_forever()

