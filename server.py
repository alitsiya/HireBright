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
    
    print "\n\n\n\n", session, '\n\n\n'
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
                print "\n Incorrect password\n\n"
                flash("Incorrect password")

                return redirect("/signin")

            else:
                print "\n Logged in - SUCCSESS!!!"
                session['email'] = email
                flash("Logged in as recruiter %s %s" % (existing_hr.first_name, existing_hr.last_name))

                return redirect("/data")

        if existing_user:
            if not bcrypt.check_password_hash(existing_user.password, password):
                print "\n Incorrect password\n\n"
                flash("Incorrect password")

                return redirect("/signin")

            else:
                print "\n Logged in - SUCCSESS!!!"
                session['email'] = email
                flash("Logged in as applicant %s %s" % (existing_user.first_name, existing_user.last_name))
                print "SESSION:\n\n\n\n\n\n", session
                print "SESSION EMAIL\n\n\n\n\n\n", session["email"]
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
        flash("%s %s has been signed up" % (first_name, last_name))
        return redirect("/data")
    else: 
        flash("Something went wrong")
        return redirect("signup")


@app.route('/logout')
def sign_out():
    """Log out users"""
    
    if session:
        
        del session['email']
        flash("The user has logged out")

    return redirect("/")


@app.route('/submit-application', methods=["GET"])
def application_render():
    """When user clicks to submit button, application goes to database"""

    return render_template('application.html')


@app.route('/submit-application', methods=["POST"])
def application_submit():
    """When user clicks to submit button, application goes to database and inserts
    user, resume, interview
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
    salary = request.form.get('salary')
    text_file = request.files['file']

    #check if user already exists
    existing_user = User.query.filter(User.email == email).first()
    print text_file
    print "\n\n\n", existing_user, "\n\n\n"
    if existing_user:
        flash("User with that email already exists, use sign-in page to edit your application.")
        print "\n\n\n", existing_user, "\n\n\n"
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
        
        resume_text = file_contents.translate(None, string.punctuation)
        resume_text = resume_text.strip().lower().replace('\n', ' ')

        print "\n\n\n PDF read SUCCESS"

    elif file_name.split('.')[1] == 'txt':
        #resume for display
        file_contents = text_file.stream.read().decode("utf-8")
        file_contents = file_contents.replace(u'\u2019', u'\'').encode('ascii', 'ignore')

        #resume type for search
        resume_text = file_contents.translate(None, string.punctuation)
        resume_text = resume_text.strip().lower().replace('\n', ' ')
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
    return redirect('/')


@app.route('/view-status')
def render_view_status():
    """Renders view status page when user signed in"""

    if session:
        email = session['email']

        user = User.query.filter(User.email == email).first()

        interview = Interview.query.filter(Interview.user_id==user.user_id).one()
        print user.interview
    else:

        flash("You are not logged in")
        return redirect("/")

    return render_template("status.html", user=user, interview=interview)


@app.route('/data')
def render_data():
    """Renders data page when recruiter signed in"""

    if session:
        email = session['email']
        recruiter = Recruiter.query.filter(email == email).first()
        if recruiter:
            users = User.query.all()

            return render_template("data.html", users=users)
        else:
            flash("You don't have permissions to view a content")
            return redirect("/")
    else:
        flash("You are not logged in")
        return redirect("/")
    

@app.route('/users/<int:user_id>')
def show_user_data(user_id):
    """Shows data for particular user """

    if session:
        email = session['email']
        recruiter = Recruiter.query.filter(email == email).first()
        if recruiter:
            user = User.query.get(user_id)
            interview = Interview.query.filter(Interview.user_id==user.user_id).first()
            recruiters = Recruiter.query.all()

            #may want to grub user github profile
            d = None
            try:
                req = urllib2.Request('https://api.github.com/users/'+user.github, None, {"Authorization": 'token '+os.environ['GITHUB_AUTH_TOKEN']})
                github_data = urllib2.urlopen(req).read()

                json_acceptable_string = github_data.replace("'", "\"")

                d = json.loads(json_acceptable_string)
                print "\n\n\nkeys", d.keys()

                print "\n\n\nGITHUB", d
            except IOError as e:
                print "I/O error({0}): {1}".format(e.errno, e.strerror)
            except ValueError:
                print "Could not convert data to a dictionary"
            except:
                print "Unexpected error:"
                raise

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

    message = client.messages.create(to="+14252143104", from_=os.environ['TWILIO_NUMBER'],
                                     body="Your interview with HireBright scheduled on %s " % (str(date_object)),
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

    return render_template('search.html')


@app.route('/search', methods=['POST'])
def search():
    """Search using inverted index for keywords"""

    #take data from ajax request and split it to multiply queries
    search_query = request.json['search_query'].lower().split(' ')

    results = []
    res_dict = {}
    for s_query in search_query:
        # r1 = Resume.query.filter(Resume.resume_search_idx.like("%"+s_query+"%")).all()
        # print "\n\n\nR1", r1
        result = Resume.query.filter(Resume.resume_string.like("%"+s_query+"%")).all()
        print "\n\n\nRESULT:", results
        results.extend(result)

    for resume in set(results):

        if res_dict.get(resume.user[0].user_id):
            pass
        else:
            res_dict[resume.user[0].user_id] = {'resume': resume.resume_text, 'user': resume.user[0].first_name + ' ' + resume.user[0].last_name, 'email': resume.user[0].email}

    return jsonify(res_dict)


@app.route('/interviews')
def show_interviews():
    """"""

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


@app.route('/tool')
def render_tool():
    """Renders pair programming tool"""

    return render_template('tool.html')


@app.route("/socket.io/<path:path>")
def run_socketio(path):
    socketio_manage(request.environ, {'': ChatNamespace})


if __name__ == "__main__":

    # We have to set debug=True here, since it has to be True at the point
    # that we invoke the DebugToolbarExtension
    # app.debug = True
    DebugToolbarExtension(app)

    connect_to_db(app)

    # app.run()

    print 'Listening on http://localhost:5000'
    app.debug = True
    import os
    from werkzeug.wsgi import SharedDataMiddleware
    app = SharedDataMiddleware(app, {
        '/': os.path.join(os.path.dirname(__file__), 'static')
        })
    from socketio.server import SocketIOServer
    SocketIOServer(('0.0.0.0', 5000), app,
        resource="socket.io", policy_server=False).serve_forever()

    # Use the DebugToolbar


