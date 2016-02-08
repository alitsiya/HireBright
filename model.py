"""Models and database functions for Interviewer project."""

from flask_sqlalchemy import SQLAlchemy


db = SQLAlchemy()

class Recruter(db.Model):
    """Recruter table """

    __tablename__ = "recruters"
    recruter_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    first_name = db.Column(db.String(20), nullable=False)
    last_name = db.Column(db.String(20), nullable=False)
    email = db.Column(db.String(20), nullable=False)
    title = db.Column(db.String(30))
    phone = db.Column(db.String(30))

    def __repr__(self):
        """Show recruter's info"""
        return "<recruter_id=%s first_name=%s last_name=%s title=%s>" % (self.recruter_id, self.first_name, 
                                                            self.last_name, self.title)


class User(db.Model):
    """Candidate table """

    __tablename__ = "users"
    user_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    first_name = db.Column(db.String(20), nullable=False)
    last_name = db.Column(db.String(20), nullable=False)
    email = db.Column(db.String(30), nullable=False)
    phone = db.Column(db.String(30), nullable=False)
    linkedin = db.Column(db.String(60))
    github = db.Column(db.String(20))

    def __repr__(self):
        """Show candidate's info"""
        return "<user_id=%s first_name=%s last_name=%s email=%s>" % (self.user_id, self.first_name, 
                                                            self.last_name, self.email)

class Resume(db.Model):
    """Resume table"""

    __tablename__ = "resumes"
    resume_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    resume_text = db.Column(db.String(100000), nullable=False)

    def __repr__(self):
        """Show resume's info"""
        return "<resume_id=%s>" % (self.resume_id)


class Tool(db.Model):
    """Pair-programming tool table"""

    __tablename__ = "tools"
    link_id  = db.Column(db.Integer, autoincrement=True, primary_key=True)
    link = db.Column(db.String(10), nullable=False)
    content = db.Column(db.String(100000))

    def __repr__(self):
        """Show pair-programming tool's info"""
        return "<link_id=%s link=%s>" % (self.link_id, self.link)


class Position(db.Model):
    """List of positions table"""

    __tablename__ = "positions"
    pos_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    position_name = db.Column(db.String(50), nullable=False)

    def __repr__(self):
        """Show position's info"""
        return "<pos_id=%s position_name=%s>" % (self.pos_id, self.position_name)


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
    user_id = db.Column(db.Integer, db.ForeignKey('users.user_id'), nullable=False)
    recruter_id = db.Column(db.Integer, db.ForeignKey('recruters.recruter_id'))
    status_id = db.Column(db.Integer, db.ForeignKey('statuses.status_id'), nullable=False)
    link_id = db.Column(db.Integer, db.ForeignKey('tools.link_id'))
    interview_date = db.Column(db.DateTime)

    user = db.relationship('User', backref=db.backref("interview", order_by=user_id))
    recruter = db.relationship('Recruter', backref=db.backref("interview", order_by=recruter_id))
    status = db.relationship('Status', backref=db.backref("interview", order_by=status_id))
    tool = db.relationship('Tool', backref=db.backref("interview", order_by=link_id))

    def __repr__(self):
        """Show interview process's info"""
        return "<interview_id=%s user_id=%s status_id=%s link_id=%s>" % (self.interview_id, self.user_id, 
                                                            self.status_id, self.link_id)


class Submission(db.Model):
    """Info about submission table """

    __tablename__ = "submissions"
    sub_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.user_id'), nullable=False)
    position_id = db.Column(db.Integer, db.ForeignKey('positions.pos_id'), nullable=True)
    salary = db.Column(db.Integer)
    resume_id = db.Column(db.Integer, db.ForeignKey('resumes.resume_id'), nullable=False)
    time_of_submission = db.Column(db.DateTime, nullable=False)

    user = db.relationship('User', backref=db.backref("submission", order_by=user_id))
    position = db.relationship('Position', backref=db.backref("submission", order_by=position_id))
    resume = db.relationship('Resume', backref=db.backref("submission", order_by=sub_id))

    def __repr__(self):
        """Show submission's info"""
        return "<sub_id=%s user_id=%s position_id=%s resume_id=%s>" % (self.sub_id, self.user_id, 
                                                            self.position_id, self.resume_id)



def connect_to_db(app):
    """Connect the database to our Flask app."""

    # Configure to use our SQLite database
    app.config['SQLALCHEMY_DATABASE_URI'] = 'postgres:///interviewer'
    app.config['SQLALCHEMY_ECHO'] = True
    db.app = app
    db.init_app(app)


if __name__ == "__main__":
    from flask import Flask
    app = Flask(__name__)

    connect_to_db(app)
    print "Connected to DB."
