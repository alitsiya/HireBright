from flask import Flask, render_template, redirect, request, flash, session
from flask_debugtoolbar import DebugToolbarExtension

from model import connect_to_db, db

app = Flask(__name__)

app.secret_key = 'Shhhhhhhhh'

@app.route('/')
def index():
    """Homepage"""

    return render_template("homepage.html")


@app.route('/about')
def about():
    """About page"""

    return render_template("about.html")


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
    existing_user = User.query.filter_by(email = email).first()

    if not existing_user:
    # if user doesn't exist - add user to db  and redirect
        flash("You're not registered. Do you want to sign up?")
        return redirect('/signup')
    else:    
        if existing_user.password != password:
            print "\n Incorrect password\n\n"
            flash("Incorrect password")
            
            return redirect("/signin")
        
        else:
            print "\n Logged in - SUCCSESS!!!"
            session['email'] = email
            flash("Logged in as %s" % email)

    return redirect("/")

@app.route('/signup', methods=['GET'])
def sign_up_form():
    """Sign Up page"""

    return render_template("sign-up.html")

@app.route('/signup', methods=['POST'])
def sign_up():
    """Handles Sign Up page input"""
    email = request.form.get('email')
    password = request.form.get('password')
    secretkey = request.form.get('secretkey')

    # user = User(email=email,
    #             password=password,
    #             age=age,
    #             occupation=occupation,
    #             zipcode=zipcode,
    #                 )

    # print "\nAdded to Database \n"

    # db.session.add(user)
    # db.session.commit()
    # session['email'] = email
    # flash("%s has been added" % email) 
    return redirect("/")


@app.route('/logout')
def sign_out():
    """Log out users"""

    if session: 
        del session['email']
        flash("The user has logged out")
    
    return redirect("/")


@app.route('/submitapplication', methods=["GET"])
def application_render():
    """When user clicks to submit button, application goes to database"""

    return render_template('application.html')


@app.route('/submitapplication', methods=["POST"])
def application_submit():
    """When user clicks to submit button, application goes to database"""

    return redirect('/')


if __name__ == "__main__":
    # We have to set debug=True here, since it has to be True at the point
    # that we invoke the DebugToolbarExtension
    app.debug = True

    # Use the DebugToolbar
    DebugToolbarExtension(app)

    app.run()