import string
from flask import Flask, render_template, redirect, request, flash, session
from flask_debugtoolbar import DebugToolbarExtension

from model import Recruter, User, Resume, Tool, Opening, Status, Interview, Submission, connect_to_db, db

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
    existing_hr = Recruter.query.filter_by(email=email).first()

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
        recruter = Recruter(
                    first_name=first_name,
                    last_name=last_name,
                    email=email,
                    password=password,
                    title=title,
                    phone=phone,
                    )
        db.session.add(recruter)
        db.session.commit()
        print "\n Recruter Added to Database \n"
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

def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1] in ALLOWED_EXTENSIONS

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

    if not text_file:
        flash('Some problems with a file')
        return redirect('/submit-application')

    #str for display
    file_contents = text_file.stream.read().decode("utf-8") 
    file_contents = file_contents.replace(u'\u2019', u'\'').encode('ascii', 'ignore')
    print type(file_contents)
    #str type for search
    resume_text = file_contents.translate(None, string.punctuation) #file for search
    resume_text = resume_text.strip().lower().replace('\n', ' ')
    
    resume = Resume(
                    resume_text=file_contents,
                    resume_string=resume_text,
                    )
    db.session.add(resume)
    print "\n Resume Added to Database \n"
    db.session.flush()
    print 'WHHOOOOOOOOOOOO id', resume.resume_id
    db.session.commit()

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
                    )
    db.session.add(user)
    print "\n User Added to Database \n"
    db.session.flush()
    print "UUUUUUSEeEEEEEER user.user_id", user.user_id

    status_name = Status.query.filter(Status.status_name == 'New').one()
    interview = Interview (
                        user_id=user.user_id,
                        status_id=status_name.status_id) 
    db.session.add(interview)
    print "\n Interview Added to Database \n"
    flash("%s, thank you for applying! You can review your information on status page", first_name)
    db.session.commit()

    text_file.close()
    return redirect('/')


@app.route('/status')
def render_view_status():
    """Renders view status page when user signed in"""

    
    return render_template("status.html")


@app.route('/data')
def render_data():
    """Renders data page when recruter signed in"""

    return render_template("data.html")


if __name__ == "__main__":
    # We have to set debug=True here, since it has to be True at the point
    # that we invoke the DebugToolbarExtension
    app.debug = True

    # Use the DebugToolbar
    DebugToolbarExtension(app)

    connect_to_db(app)

    app.run()