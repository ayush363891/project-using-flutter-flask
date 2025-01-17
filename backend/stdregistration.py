from flask import Flask, request, jsonify
from flask_cors import CORS
from datetime import datetime

app = Flask(__name__)
CORS(app)  # Enable CORS for cross-origin requests

# Helper function to create responses
def create_response(success, message, status_code=200):
    return jsonify({"success": success, "message": message}), status_code

# Registration Route
@app.route('/register', methods=['POST'])
def registration():
    data = request.get_json()  # Parse JSON request data

    # Extracting fields
    name = data.get('name')
    mother_name = data.get('mother_name')  # Ensure this matches Flutter's key
    dob = data.get('dob')
    gender = data.get('gender')
    mobile = data.get('mobile')
    address = data.get('address')
    department = data.get('department')
    course = data.get('course')
    year = data.get('year')

    # Validate required fields
    if not name:
        return create_response(False, "Please enter name", 400)
    elif not mother_name:
        return create_response(False, "Please enter Mother's name", 400)
    elif not mobile:
        return create_response(False, "Please enter Mobile number", 400)
    elif not address:
        return create_response(False, "Please enter Address", 400)
    elif not mobile.isdigit() or len(mobile) != 10:
        return create_response(False, "Please enter a valid 10-digit Mobile number", 400)
    elif dob and not validate_date_format(dob):
        return create_response(False, "Please enter DOB in YYYY-MM-DD format", 400)
    else:
        # If all validations pass, send success response
        return create_response(True, "Registration successful")

# Helper function to validate date format
def validate_date_format(date_str):
    try:
        datetime.strptime(date_str, "%Y-%m-%d")  # Validate format YYYY-MM-DD
        return True
    except ValueError:
        return False

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0')  # Listen on all interfaces
