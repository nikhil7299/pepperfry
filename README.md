# pepperfry

A new Flutter project.

To run this project -
1 -> run - flutter pub get
2 -> cd server - run - npm install
3 -> Add IP in env.dart
4 -> Configure /server/.env
server/.env ->
PORT = <YOUR_PORT>
JWT_SECRET ='<YOUR_JWT_SECRET'
MONGO_URL = '<YOUR_MONGO_DB_URL>/pepperfry?retryWrites=true&w=majority'

TWILIO_ACCOUNT_SID = "YOUR_TWILIO_ACCOUNT_SID"
TWILIO_AUTH_TOKEN = "YOUR_TWILIO_AUTH_TOKEN"
TWILIO_SERVICE_SID = "YOUR_TWILIO_SERVICE_SID"
