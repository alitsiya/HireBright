# Download the twilio-python library from http://twilio.com/docs/libraries
from twilio.rest import TwilioRestClient
import os

# Find these values at https://twilio.com/user/account
account_sid = os.environ['TWILIO_ACCOUNT_SID']
auth_token = os.environ['TWILIO_AUTH_TOKEN']
client = TwilioRestClient(account_sid, auth_token)
 
message = client.messages.create(to="+14252143104", from_=os.environ['TWILIO_NUMBER'],
                                     body="Test from Twilio! You are  awesome!",
                                )