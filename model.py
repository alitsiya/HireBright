"""Models and database functions for Interviewer project."""

from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
from sqlalchemy import Index

db = SQLAlchemy()


class Recruiter(db.Model):
    """Recruiter table """

    __tablename__ = "recruiters"
    recruiter_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    first_name = db.Column(db.String(20), nullable=False)
    last_name = db.Column(db.String(20), nullable=False)
    password = db.Column(db.String(60), nullable=False)
    email = db.Column(db.String(20), nullable=False)
    title = db.Column(db.String(30))
    phone = db.Column(db.String(30))

    def __repr__(self):
        """Show recruiter's info"""
        return "<recruiter_id=%s first_name=%s last_name=%s title=%s>" % (self.recruiter_id, self.first_name,
                                                                         self.last_name, self.title)


class User(db.Model):
    """Candidate table """

    __tablename__ = "users"
    user_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    first_name = db.Column(db.String(20), nullable=False)
    last_name = db.Column(db.String(20), nullable=False)
    password = db.Column(db.String(60), nullable=False)
    location = db.Column(db.String(50))
    email = db.Column(db.String(30), nullable=False)
    phone = db.Column(db.String(30), nullable=False)
    linkedin = db.Column(db.String(60))
    github = db.Column(db.String(20))
    position = db.Column(db.String(30))
    salary = db.Column(db.Integer)
    resume_id = db.Column(db.Integer, db.ForeignKey('resumes.resume_id', ondelete='CASCADE'))
    time_of_submission = db.Column(db.DateTime, default=datetime.now, nullable=False)

    resume = db.relationship('Resume', backref=db.backref("user", order_by=resume_id, cascade="all, delete"), cascade="all, delete", cascade_backrefs=True)

    def __repr__(self):
        """Show candidate's info"""
        return "<user_id=%s first_name=%s last_name=%s email=%s>" % (self.user_id, self.first_name,
                                                                     self.last_name, self.email)

class Resume(db.Model):
    """Resume table"""

    __tablename__ = "resumes"
    resume_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    resume_text = db.Column(db.String(50000), nullable=False)
    resume_string = db.Column(db.String(50000), nullable=False)

    def __repr__(self):
        """Show resume's info"""
        return "<resume_id=%s>" % (self.resume_id)


class Tool(db.Model):
    """Pair-programming tool table"""

    __tablename__ = "tools"
    link_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    link = db.Column(db.String(10), nullable=False)
    content = db.Column(db.String(100000))

    def __repr__(self):
        """Show pair-programming tool's info"""
        return "<link_id=%s link=%s>" % (self.link_id, self.link)


class Opening(db.Model):
    """List of positions table"""

    __tablename__ = "openings"
    opening_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    opening_name = db.Column(db.String(50), nullable=False)
    opening_description = db.Column(db.String(500))

    def __repr__(self):
        """Show opening's info"""
        return "<pos_id=%s vacancy_name=%s>" % (self.opening_id, self.opening_name)


class Status(db.Model):
    """List of interview statuses table"""

    __tablename__ = "statuses"
    status_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    status_name = db.Column(db.String(50), nullable=False)

    def __repr__(self):
        """Show interview statuse's info"""
        return "<status_id=%s status_name=%s>" % (self.status_id, self.status_name)


class Interview(db.Model):
    """Interview process table """

    __tablename__ = "interviews"
    interview_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.user_id', ondelete='CASCADE'), nullable=False)
    recruiter_id = db.Column(db.Integer, db.ForeignKey('recruiters.recruiter_id'))
    status_id = db.Column(db.Integer, db.ForeignKey('statuses.status_id'), nullable=False)
    link_id = db.Column(db.Integer, db.ForeignKey('tools.link_id'))
    interview_date = db.Column(db.DateTime)

    user = db.relationship('User', backref=db.backref("interview", order_by=user_id, cascade="all, delete", cascade_backrefs=True), cascade="all", cascade_backrefs=True)
    recruiter = db.relationship('Recruiter', backref=db.backref("interview", order_by=recruiter_id))
    status = db.relationship('Status', backref=db.backref("interview", order_by=status_id))
    tool = db.relationship('Tool', backref=db.backref("interview", order_by=link_id))

    def __repr__(self):
        """Show interview process's info"""
        return "<interview_id=%s user_id=%s status_id=%s link_id=%s>" % (self.interview_id, self.user_id,
                                                                         self.status_id, self.link_id)



def connect_to_db(app, db_uri=None):
    """Connect the database to our Flask app."""

    app.config['SQLALCHEMY_DATABASE_URI'] = db_uri or 'postgresql:///interviewer'
    app.config['SQLALCHEMY_ECHO'] = True
    db.init_app(app)
    db.app = app


if __name__ == "__main__":
    from flask import Flask
    app = Flask(__name__)

    connect_to_db(app)
    print "Connected to DB on //localhost:5000."
