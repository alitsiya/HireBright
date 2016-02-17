import string
from gevent import monkey; monkey.patch_all()
from flask import Flask, render_template, redirect, request, flash, session
from flask_debugtoolbar import DebugToolbarExtension

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

app.secret_key = 'Shhhhhhhhh'


@app.route('/')
def index():
    """Homepage"""

    return render_template("homepage.html")


@app.route('/interview')
def interview():
    """Render interview pair programming tool page"""

    pass


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
            if existing_hr.password != password:
                print "\n Incorrect password\n\n"
                flash("Incorrect password")

                return redirect("/signin")

            else:
                print "\n Logged in - SUCCSESS!!!"
                session['email'] = email
                flash("Logged in as %s %s" % (existing_hr.first_name, existing_hr.last_name))

                return redirect("/data")

        if existing_user:
            if existing_user.password != password:
                print "\n Incorrect password\n\n"
                flash("Incorrect password")

                return redirect("/signin")

            else:
                print "\n Logged in - SUCCSESS!!!"
                session['email'] = email
                flash("Logged in as %s %s" % (existing_user.first_name, existing_user.last_name))

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
                    password=password,
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
    existing_user = User.query.filter(email == email).first()
    if existing_user:
        flash("User with that email already exists, use sign-in page to edit your application.")
        return redirect('/signin')

    #checks if there is an attached file
    if not text_file:
        flash('Some problems with your attachment')
        return redirect('/submit-application')

    #resume for display
    file_contents = text_file.stream.read().decode("utf-8")
    file_contents = file_contents.replace(u'\u2019', u'\'').encode('ascii', 'ignore')
    print type(file_contents)
    #resume type for search
    resume_text = file_contents.translate(None, string.punctuation)
    resume_text = resume_text.strip().lower().replace('\n', ' ')

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
                    password=password,
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
    flash("%s, thank you for applying! You can review your information on status page", user.first_name)
    db.session.commit()

    text_file.close()
    return redirect('/')


@app.route('/view-status')
def render_view_status():
    """Renders view status page when user signed in"""
    if session:
        email = session['email']
        user = User.query.filter(email == email).first()
        interview = Interview.query.filter(Interview.user_id==user.user_id).first()
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
            print recruiters
            return render_template("user.html", user=user, interview=interview, recruiters=recruiters)
        else:
            flash("You don't have permissions to view a content")
            return redirect("/")
    else:
        flash("You are not logged in")
        return redirect("/")
    
@app.route('/schedule_interview')
def put_interview_db(data):

    pass


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


