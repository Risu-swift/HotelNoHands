from flask import Flask
from flask.json import jsonify
app = Flask(__name__)

cache = {}

@app.route("/create")
def create():
    cache['foo'] = 0
    print((cache))
    return (cache)

@app.route("/unlock")
def unlock():
    cache['foo'] = 1
    return (cache)

@app.route("/lock")
def lock():
    cache['foo'] = 0
    return (cache)

@app.route("/read")
def read():
    return (cache)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port= 8090)