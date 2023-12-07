const bearer_token = "eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICI1N1R4M2FWRzR0N0Q5YW00TDlod1VHR2tPVVlvOUpwVFd1VTNmTWxrY1lBIn0.eyJleHAiOjE3MDAyNzQ1NDUsImlhdCI6MTcwMDI3NDI0NSwianRpIjoiYjczY2IwNWMtYTgzOC00ZTg0LWIzYWYtMTM3ZjRhNDQxYzRmIiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo4MDgwL2F1dGgvcmVhbG1zL2Jvb3RhZG1pbiIsImF1ZCI6WyJhcHAtYWRtaW4iLCJhcHAtdG9kbyIsImFjY291bnQiXSwic3ViIjoiMmEzNzU0NzAtMjU4Ni00MDM4LWEzODUtMTY1OGMxOGVjMTJhIiwidHlwIjoiQmVhcmVyIiwiYXpwIjoiYXBwLWltcyIsInNlc3Npb25fc3RhdGUiOiJlMGZlMjc2MS02NzkyLTQyNjktYjU4MC05NGJmM2Q0MzZjNjYiLCJhY3IiOiIxIiwicmVhbG1fYWNjZXNzIjp7InJvbGVzIjpbIm9mZmxpbmVfYWNjZXNzIiwidW1hX2F1dGhvcml6YXRpb24iXX0sInJlc291cmNlX2FjY2VzcyI6eyJhcHAtYWRtaW4iOnsicm9sZXMiOlsiYWRtaW4iXX0sImFwcC10b2RvIjp7InJvbGVzIjpbImFkbWluIiwidXNlciJdfSwiYWNjb3VudCI6eyJyb2xlcyI6WyJtYW5hZ2UtYWNjb3VudCIsIm1hbmFnZS1hY2NvdW50LWxpbmtzIiwidmlldy1wcm9maWxlIl19fSwic2NvcGUiOiJvcGVuaWQgZW1haWwgcHJvZmlsZSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicHJlZmVycmVkX3VzZXJuYW1lIjoiZm9ya2l0LWhhY2thdGhvbiJ9.Yw7PGKdw6I2_CWYeqFr5-hQBw-zmz4Kn5BVY5DnVRydtzfAIk_If3MA9TXaOwhSLc1GAaRcqB1aDhQ2NcM3cciaeBqVxW75rxaYBSvRMhvUWYS_FSY1IVsBh32t4GEojVab_CNjqb-6Xif4hfBgwYTZbEDBThFCKRZbNfBM9etlLJFgJ8HuLns_A3R-fDf1jbr7Qqc0S8pXkfk6v6dmTgDqmsnA8DHnm4MTKd4Y4SiCax3Da_BxC-wglg3m3i-KDXdU-tZtJ6QcboRlB8EhNn1o59XNf0HhBxeroZznzjDh5waFlqMD-wihAzGI_l1KUPvUzjDGNjyRJn1HzFBOxmA";
const headers = {
    "Authorization": `Bearer ${bearer_token}`,
    "Content-Type": "application/json",
};
const params = {"client_id": "app-ims", "grant_type": "password", "username": "forkit-hackathon", "password": "forkitiiitdelhi", "scope": "openid"};

const base_url = "https://cosylab.iiitd.edu.in/api/recipeDB/search_subregion/";

function make_api_request(prompt) {
    const keys = prompt.split("-");
    const complete_url = base_url + keys[0];

    fetch(complete_url, { headers, params })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            extract_recipe_titles(data);
        })
        .catch(error => {
            console.error('There was a problem with the fetch operation:', error);
            st.write("Error: Unable to fetch data.");
        });
}

function display_image_from_url(img_url) {
    try {
        fetch(img_url)
            .then(response => response.blob())
            .then(blob => {
                const img = new Image();
                img.src = URL.createObjectURL(blob);
                document.body.appendChild(img);
            });
    } catch (e) {
        console.error(`Error displaying image: ${e}`);
        st.write(`Error displaying image: ${e}`);
    }
}

function extract_recipe_titles(response_text) {
    for (const element of response_text) {
        const calories = element["calories"];
        const proteins = element["protein"];
        if (keys.length == 3) {
            if (parseInt(keys[1]) == 0) {
                if (proteins < parseInt(keys[2]) + 5 && proteins > parseInt(keys[2]) - 5) {
                    const recipe = "";
                    if ('img_url' in element) {
                        display_image_from_url(element['img_url']);
                    }
                    console.log(recipe);
                    console.log("-------------------------------------------------------------------------------------------------------------------");
                }
            } else if ((calories < parseInt(keys[1]) + 10 && calories > parseInt(keys[1]) - 10) && (proteins < parseInt(keys[2]) + 5 && proteins > parseInt(keys[2]) - 5)) {
                const recipe = "";
                if ('img_url' in element) {
                    display_image_from_url(element['img_url']);
                }
                console.log(recipe);
                console.log("-------------------------------------------------------------------------------------------------------------------");
            }
        } else if (keys.length == 2) {
            if (calories < parseInt(keys[1]) + 10 && calories > parseInt(keys[1]) - 10) {
                const recipe = "";
                if ('img_url' in element) {
                    display_image_from_url(element['img_url']);
                }
                console.log(recipe);
                console.log("-------------------------------------------------------------------------------------------------------------------");
            }
        } else {
            const recipe = "";
            if ('img_url' in element) {
                display_image_from_url(element['img_url']);
            }
            console.log(recipe);
            console.log("-------------------------------------------------------------------------------------------------------------------");
        }
    }
}

function getAPIResponse() {
    const promptInput = document.getElementById('chatInput');
    const promptValue = promptInput.value.trim();

    if (promptValue) {
        make_api_request(promptValue);
    } else {
        alert('Please enter a prompt.');
    }
}

const submitBtn = document.getElementById('submitBtn');
submitBtn.addEventListener('click', getAPIResponse);