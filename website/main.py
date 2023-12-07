import os
import requests
from PIL import Image
from io import BytesIO

bearer_token = "YOUR_BEARER_TOKEN"  # Replace with your actual bearer token
headers = {
    "Authorization": f"Bearer {bearer_token}",
    "Content-Type": "application/json",
}

params = {
    "client_id": "app-ims",
    "grant_type": "password",
    "username": "forkit-hackathon",
    "password": "forkitiiitdelhi",
    "scope": "openid",
}

base_url = "https://cosylab.iiitd.edu.in/api/recipeDB/search_subregion/"

def make_api_request(cuisine_name):
    # Construct the complete URL for the API request
    complete_url = base_url + cuisine_name

    # Send a request to the public API with headers
    response = requests.get(complete_url, headers=headers, params=params)

    # Check the status of the response
    if response.status_code == 200:
        # Extract the response text from the API's response
        response_text = response.json()
        return response_text
    else:
        return None

def extract_recipe_titles(response_text):
    # Your existing function to extract recipe titles
    pass

@app.route('/')
def index():
    return render_template('cuisines.html')

@app.route('/api/cuisines', methods=['GET', 'POST'])
def get_cuisines():
    if request.method == 'GET':
        # Get the prompt from the query parameters
        prompt = request.args.get('prompt', '')
    elif request.method == 'POST':
        # Get the prompt from the form data
        prompt = request.form.get('chatInput', '')

    keys = prompt.split("-")
    response_text = make_api_request(keys[0])

    if response_text:
        titles = extract_recipe_titles(response_text)
        return jsonify(titles)
    else:
        return 'Error fetching data'

if __name__ == '__main__':
    app.run(debug=True)