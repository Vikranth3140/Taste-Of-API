import os
import requests
import streamlit as st
from PIL import Image
from io import BytesIO

# Bearer token
bearer_token = "eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICI1N1R4M2FWRzR0N0Q5YW00TDlod1VHR2tPVVlvOUpwVFd1VTNmTWxrY1lBIn0.eyJleHAiOjE3MDAyNzMxMTYsImlhdCI6MTcwMDI3MjgxNiwianRpIjoiOGU4MDU4YWYtM2VjZi00MTFkLWIwODYtYmQ4Yzg0MmJjYzA5IiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo4MDgwL2F1dGgvcmVhbG1zL2Jvb3RhZG1pbiIsImF1ZCI6WyJhcHAtYWRtaW4iLCJhcHAtdG9kbyIsImFjY291bnQiXSwic3ViIjoiMmEzNzU0NzAtMjU4Ni00MDM4LWEzODUtMTY1OGMxOGVjMTJhIiwidHlwIjoiQmVhcmVyIiwiYXpwIjoiYXBwLWltcyIsInNlc3Npb25fc3RhdGUiOiI5MDkwOWRkYy1lZjFiLTQzMTQtYWE1Zi01ZjlmMzE2OWQ1MjciLCJhY3IiOiIxIiwicmVhbG1fYWNjZXNzIjp7InJvbGVzIjpbIm9mZmxpbmVfYWNjZXNzIiwidW1hX2F1dGhvcml6YXRpb24iXX0sInJlc291cmNlX2FjY2VzcyI6eyJhcHAtYWRtaW4iOnsicm9sZXMiOlsiYWRtaW4iXX0sImFwcC10b2RvIjp7InJvbGVzIjpbImFkbWluIiwidXNlciJdfSwiYWNjb3VudCI6eyJyb2xlcyI6WyJtYW5hZ2UtYWNjb3VudCIsIm1hbmFnZS1hY2NvdW50LWxpbmtzIiwidmlldy1wcm9maWxlIl19fSwic2NvcGUiOiJvcGVuaWQgZW1haWwgcHJvZmlsZSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicHJlZmVycmVkX3VzZXJuYW1lIjoiZm9ya2l0LWhhY2thdGhvbiJ9.cagGgiq4ne0R2rlAfVDX8gVtcoD8_xPBkK453hnGzkdeAbu5sAVdeG8ARSELIngjV4IagDmw_DLTDZkBcQw9Onv37wtgcjLimVCGtcB8SKEpEWZrgS4mTOauIW6EPhQ4VUXYegMwQz4cTYu8xkvwEr0ivIOwUIknSuaZnpeSDsmnFy3oJcxHJnKVx3X1qWZv42d0Ci3mbqANuCQL42u-TffRANMz4zdhBNqSItJRofYtvPiBsKgM3n3DAiVkUTpuctMY9aSLwjqhKXNnR2OXwACHFy7xoTm5yufwClIPEzwHNpWMtbCZ1bUZxfSIPI61vnNqIhiFc9XcMtqCjtEQ8A"

headers = {
        "Authorization": f"Bearer {bearer_token}",
        "Content-Type": "application/json",
    }

params = {"client_id": "app-ims", "grant_type": "password" , "username":"forkit-hackathon" , "password":"forkitiiitdelhi" , "scope":"openid"}
# Public API URL
base_url = "https://cosylab.iiitd.edu.in/api/entity/entityautocomplete?name="

# App Framework
st.title("Taste Of API")

st.markdown(
    "<h3 style='color: lightgrey; font-family: Helvetica, sans-serif; font-size: 14px;'>Simply enter the name of a dish you love, and let us whisk you away to a world of delightful flavors</h3>",
    unsafe_allow_html=True
)
# Take user input and add placeholder
prompt = st.text_input("Type here!")
# Function to make API request and handle response
def make_api_request(prompt):
    
    complete_url = base_url + prompt
    # Send a request to the public API with headers
    response = requests.get(complete_url, headers=headers, params=params)
    # Check the status of the response
    if response.status_code == 200:
        # Extract the response text from the API's response
        response_text = response.json()
        return response_text
    else:
        st.write("Error: Unable to fetch data.")
        return None

# Show things on the screen if prompt exists
# Show things on the screen if prompt exists
if st.button("Submit"):
    if prompt:
        response_text = make_api_request(prompt)

        if response_text:
            for val in response_text:
                st.write(val)
        else:
            st.write("No results found!")