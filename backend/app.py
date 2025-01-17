from flask import Flask,request,jsonify
from flask_cors import CORS

app=Flask(__name__)
CORS(app)

@app.route('/login',methods=['POST'])
def login():
    data=request.get_json()
    username=data.get('username')
    password=data.get('password')

    if username=="user" and password=="12345":
        return jsonify({"success":True})
    else:
        return jsonify({"success":False,"message":"Invalid username or password"})

if __name__=="__main__":
    app.run(debug=True)
