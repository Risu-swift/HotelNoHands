from flask import Flask
 
app = Flask(__name__)
x = 'null'

@app.route('/hello')
def helloWorldHandler():
    return x

@app.route('/roomunlock')
def roomUnlockHandler():
    x = 'true'
    return 'Room Unlocked';

@app.route('/roomlock')
def roomlockHandler():
    x = 'false'
    return 'Room locked';         

@app.context_processor
def context_processor():
    return x;

app.run(host='0.0.0.0', port= 8090)