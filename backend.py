from flask import Flask, request, Response
from flask_cors import CORS, cross_origin

app = Flask(__name__)

# This allows cross-origin-resource-sharing so it can be called from other places than the same server
CORS(app)


db = ''

@app.route('/', methods = ['GET', 'POST'])
def api_root():
    global db

    if request.method == 'POST':
        db = request.get_data()

    resp = Response(response=db, status=200, mimetype="application/json")
    print resp
    return(resp)

if __name__ == '__main__':
    app.run()

