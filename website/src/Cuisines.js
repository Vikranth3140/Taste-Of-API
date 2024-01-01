import React, { useState } from 'react';
import './Cuisines.css';

const Cuisines = () => {
    const [prompt, setPrompt] = useState('');
    const [results, setResults] = useState([]);

    const clientId = 'app-ims';
    const grantType = 'password';
    const username = 'forkit-hackathon';
    const password = 'forkitiiitdelhi';
    const scope = 'openid';

    const baseUrl = 'https://cosylab.iiitd.edu.in/api/recipeDB/search_subregion/';
    const bearerToken = 'eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICI1N1R4M2FWRzR0N0Q5YW00TDlod1VHR2tPVVlvOUpwVFd1VTNmTWxrY1lBIn0.eyJleHAiOjE3MDAyNzI3MDgsImlhdCI6MTcwMDI3MjQwOCwianRpIjoiY2JkMjJkZDMtZjcyMi00MGRjLWFiZGItYzRkYmRjZDdhOWNjIiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo4MDgwL2F1dGgvcmVhbG1zL2Jvb3RhZG1pbiIsImF1ZCI6WyJhcHAtYWRtaW4iLCJhcHAtdG9kbyIsImFjY291bnQiXSwic3ViIjoiMmEzNzU0NzAtMjU4Ni00MDM4LWEzODUtMTY1OGMxOGVjMTJhIiwidHlwIjoiQmVhcmVyIiwiYXpwIjoiYXBwLWltcyIsInNlc3Npb25fc3RhdGUiOiI0MzA4NDczOS1lODVhLTQyYzMtYjM1Ny1jYTJiOTQzZGE0MmQiLCJhY3IiOiIxIiwicmVhbG1fYWNjZXNzIjp7InJvbGVzIjpbIm9mZmxpbmVfYWNjZXNzIiwidW1hX2F1dGhvcml6YXRpb24iXX0sInJlc291cmNlX2FjY2VzcyI6eyJhcHAtYWRtaW4iOnsicm9sZXMiOlsiYWRtaW4iXX0sImFwcC10b2RvIjp7InJvbGVzIjpbImFkbWluIiwidXNlciJdfSwiYWNjb3VudCI6eyJyb2xlcyI6WyJtYW5hZ2UtYWNjb3VudCIsIm1hbmFnZS1hY2NvdW50LWxpbmtzIiwidmlldy1wcm9maWxlIl19fSwic2NvcGUiOiJvcGVuaWQgZW1haWwgcHJvZmlsZSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicHJlZmVycmVkX3VzZXJuYW1lIjoiZm9ya2l0LWhhY2thdGhvbiJ9.A5QI4vwjJ32oeaDfvqCSFJIHZiojb61wCL1STFhxPg5WXYDITmeYrhHuroqfMnAK-1A3KCUt7B1NTQZTrH-xKtRU_Yj35h5YwkPwjbSho4U_5Ka0k9Zl_Z2P_Whhg9uGMRHrG8iaY3FSTXPXv1Ba4y0gT95JWdzRvNh59aReF7_6E9qEGNIgAko6Qgif2c7Zh1N5PyCo4QD-spqCqya5zx7o9lKravIHFKhmovJcudYIMSdkP-pl6kgq63G_Twq7NaaUpe5ASPuSBzul-AoUWUmctvqTDBKd2FKryBISoDI7zVZBJHXOsB9cluCXVuSPQRsGJVle_zcLGjv86h4xvw';

    const getAPIResponse = (event) => {
        event.preventDefault();

        if (prompt.trim()) {
            makeApiRequest(prompt);
        } else {
            alert('Please enter a prompt.');
        }
    };

    const makeApiRequest = (promptValue) => {
        const completeUrl = baseUrl + promptValue;

        const headers = {
            'Authorization': `Bearer ${bearerToken}`,
            'Content-Type': 'application/json',
        };

        console.log('Making API request to:', completeUrl);

        fetch(completeUrl, { headers })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                console.log('API response:', data);
                setResults(data);
            })
            .catch(error => {
                console.error('There was a problem with the fetch operation:', error);
            });
    };

    return (
        <div>
            <h1>
                Taste Of API
                <img src="/assets/TasteOfAPI.png" id="logo" alt="Taste Of API" />
            </h1>
            <nav>
                <ul>
                    <a href="index.html"><li><img src="/assets/chatbot.png" id="chatbot" alt="Chatbot" /></li></a>
                </ul>
            </nav>

            <div>
                <form id="apiForm" onSubmit={getAPIResponse}>
                    <label htmlFor="chatInput" style={{ color: "white" }}>Enter your favourite dish</label>

                    <br />
                    <input
                        type="text"
                        id="chatInput"
                        name="prompt"
                        value={prompt}
                        onChange={(e) => setPrompt(e.target.value)}
                    />
                    <br />
                    <input type="submit" id="submitBtn" value="Submit" />
                </form>
            </div>

            <div id="results">
                {results.map((element, index) => (
                    <div key={index}>
                        <p>{element.recipe_title}</p>
                        <p>Calories: {element.calories}</p>
                        <p>Protein: {element.protein}</p>
                    </div>
                ))}
            </div>
        </div >
    )
};

export default Cuisines;