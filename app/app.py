import os
import requests
import streamlit as st

api_key = "1c4aaa597dd29ba9c44da6839c89fbf6"

# Public API URL
base_url = "http://api.openweathermap.org/data/2.5/weather?"

# App Framework
st.title("Taste Of API")

# Take user input and add placeholder
prompt = st.text_input("Enter your food specifications", "Enter specifications of the form: '(Cuisine-Name)-(No. of Calories)'")

# Function to make API request and handle response
def make_api_request(prompt):
    # Check if the prompt has two values separated by "-"
    if "-" in prompt:
        keys = prompt.split("-")

        # Create the complete URL
        complete_url = base_url + "appid=" + api_key + "&q=" + keys[0]
    else:
        # Create the complete URL
        complete_url = base_url + "appid=" + api_key + "&q=" + prompt

    # Send a request to the public API
    response = requests.get(complete_url)

    # Check the status of the response
    if response.status_code == 200:
        # Extract the response text from the API's response
        response_text = response.json()
        return response_text
    else:
        st.write("Error: Unable to fetch data.")
        return None

# Show things on the screen if prompt exists
if st.button("Submit"):
    if prompt:
        response_text = make_api_request(prompt)

        # Print the entire dictionary to the screen
        print(response_text)

        if response_text:
            if "-" in prompt:
                keys = prompt.split("-")
                for i in response_text.keys():
                    if i == keys[1]:
                        st.write(response_text.get(i))
            else:
                st.write(response_text)