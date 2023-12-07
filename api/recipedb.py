import os
import requests
import streamlit as st
from PIL import Image
from io import BytesIO

# Bearer token
bearer_token = "eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICI1N1R4M2FWRzR0N0Q5YW00TDlod1VHR2tPVVlvOUpwVFd1VTNmTWxrY1lBIn0.eyJleHAiOjE3MDAyNzI4NjYsImlhdCI6MTcwMDI3MjU2NiwianRpIjoiMzIzNGIyZmUtZGNlZS00MThiLWEyYzgtMmNhYWZiNGU5NmM1IiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo4MDgwL2F1dGgvcmVhbG1zL2Jvb3RhZG1pbiIsImF1ZCI6WyJhcHAtYWRtaW4iLCJhcHAtdG9kbyIsImFjY291bnQiXSwic3ViIjoiMmEzNzU0NzAtMjU4Ni00MDM4LWEzODUtMTY1OGMxOGVjMTJhIiwidHlwIjoiQmVhcmVyIiwiYXpwIjoiYXBwLWltcyIsInNlc3Npb25fc3RhdGUiOiI5Zjg3NjZhMS0yNDdhLTQ2OTQtYTg4YS05ZDM1YzJlOWFmNzUiLCJhY3IiOiIxIiwicmVhbG1fYWNjZXNzIjp7InJvbGVzIjpbIm9mZmxpbmVfYWNjZXNzIiwidW1hX2F1dGhvcml6YXRpb24iXX0sInJlc291cmNlX2FjY2VzcyI6eyJhcHAtYWRtaW4iOnsicm9sZXMiOlsiYWRtaW4iXX0sImFwcC10b2RvIjp7InJvbGVzIjpbImFkbWluIiwidXNlciJdfSwiYWNjb3VudCI6eyJyb2xlcyI6WyJtYW5hZ2UtYWNjb3VudCIsIm1hbmFnZS1hY2NvdW50LWxpbmtzIiwidmlldy1wcm9maWxlIl19fSwic2NvcGUiOiJvcGVuaWQgZW1haWwgcHJvZmlsZSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicHJlZmVycmVkX3VzZXJuYW1lIjoiZm9ya2l0LWhhY2thdGhvbiJ9.J45O1GiJu_e-C8SPGt5reEv7Ce1w8PGodBup9rZTVeH8HpBNaYZAPpJtSKrJUF77qQ04f1OjsUJAlj0obRdlXYB2kfcSr5C6SOPADC0PLofBms_1rfOWwQw4O4Wsv6wm-_IIaUU6ZunCOG4KvE6dHOZbq0TUe1WdilsC9521Szw_ynwFav55u5i-nYZ-2JsEwmstG4KuYTEnT_BQp3Nba-VvAJt26muTAd8DKCyHPgNMIGYXNSWDp0YBe9Q2txve_nLHdmFlQXUO2q1VSL7AxxFUsbqRYejyjXtRwroKzeD_uMhcMoBcakJxW2iQTLK6jRmz-xeHwoDc61nWkTIYEw"

headers = {
        "Authorization": f"Bearer {bearer_token}",
        "Content-Type": "application/json",
    }

params = {"client_id": "app-ims", "grant_type": "password" , "username":"forkit-hackathon" , "password":"forkitiiitdelhi" , "scope":"openid"}
# Public API URL
base_url = "https://cosylab.iiitd.edu.in/api/recipeDB/search_subregion/"

# App Framework
st.title("Taste Of API")

st.markdown(
    "<h3 style='color: lightgrey; font-family: Helvetica, sans-serif; font-size: 14px;'>Enter specifications of the form: '(Cuisine-Name)-(No. of Calories)-(No. of Proteins), If no input please enter 0'</h3>",
    unsafe_allow_html=True
)
# Take user input and add placeholder
prompt = st.text_input("Type here!")
keys=[]
# Function to make API request and handle response
def make_api_request(prompt):
    global keys
    # Check if the prompt has two values separated by "-"
    keys = prompt.split("-")
    complete_url = base_url + keys[0]

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


def display_image_from_url(img_url):
    try:
        response = requests.get(img_url)
        img = Image.open(BytesIO(response.content))
        st.image(img, caption='Recipe Image', use_column_width=True)
    except Exception as e:
        st.write(f"Error displaying image: {e}")
# Show things on the screen if prompt exists
def extract_recipe_titles(response_text):

    for element in response_text:
        calories = element["calories"];proteins = element["protein"]
        if (len(keys) == 3):
            if int(keys[1]) == 0:
                if (proteins < int(keys[2])+5 and proteins > int(keys[2])-5):
                    recipe = f"""
    {element['recipe_title']}:\n
        Calories: {element['calories']}\n
        Ingredients: {element["ingredients"]}\n
        Protein: {element['protein']}\n
        Fats: {element['fat']}\n
        Energy kcal: {element['energykcal']}\n
        Carbohydrates by difference: {element['carbohydratebydifference']}
                """ 

                    if 'img_url' in element:
                        display_image_from_url(element['img_url'])
            
                    st.write(recipe)
                    st.write("-------------------------------------------------------------------------------------------------------------------")
                    
            elif ((calories < int(keys[1])+10 and calories > int(keys[1])-10) and (proteins < int(keys[2])+5 and proteins > int(keys[2])-5)):

                recipe = f"""
    {element['recipe_title']}:\n
        Calories: {element['calories']}\n
        Ingredients: {element["ingredients"]}\n
        Protein: {element['protein']}\n
        Fats: {element['fat']}\n
        Energy kcal: {element['energykcal']}\n
        Carbohydrates by difference: {element['carbohydratebydifference']}
                """ 

                if 'img_url' in element:
                    display_image_from_url(element['img_url'])

        
                st.write(recipe)
                st.write("-------------------------------------------------------------------------------------------------------------------")
        
        elif (len(keys) == 2):
            if (calories < int(keys[1])+10 and calories > int(keys[1])-10):

                recipe = f"""
    {element['recipe_title']}:\n
        Calories: {element['calories']}\n
        Ingredients: {element["ingredients"]}\n
        Protein: {element['protein']}\n
        Fats: {element['fat']}\n
        Energy kcal: {element['energykcal']}\n
        Carbohydrates by difference: {element['carbohydratebydifference']}
                """ 

                if 'img_url' in element:
                    display_image_from_url(element['img_url'])
        
                st.write(recipe)
                st.write("-------------------------------------------------------------------------------------------------------------------")

        else:
            recipe = f"""
    {element['recipe_title']}:\n
        Calories: {element['calories']}\n
        Ingredients: {element["ingredients"]}\n
        Protein: {element['protein']}\n
        Fats: {element['fat']}\n
        Energy kcal: {element['energykcal']}\n
        Carbohydrates by difference: {element['carbohydratebydifference']}
                """ 

            if 'img_url' in element:
                display_image_from_url(element['img_url'])
    
            st.write(recipe)
            st.write("-------------------------------------------------------------------------------------------------------------------")
# Show things on the screen if prompt exists
if st.button("Submit"):
    if prompt:
        response_text = make_api_request(prompt)

        if response_text:
            titles = extract_recipe_titles(response_text)
        else:
            st.write("No results found!")