from model import db, connect_to_db
from server import app
import os

connect_to_db(app, os.environ.get("DATABASE_URL"))
db.create_all()
