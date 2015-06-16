'
' Here is how to set up your developer Client ID and Client Secret for OAuth2 authentication:
'
' 1. Log in to your gmail account
' 2. Go to: https://console.developers.google.com/project
' 3. Click 'Create Project'
' 4. Click 'Create'
' 5. Wait for the screen to refresh and show the Project Dashboard
' 6. Click 'APIs & auth' in the left-hand panel
' 7. Click 'Credentials' below 'APIs & auth'
' 8. Click 'Create new Client ID'
' 9. Select 'Installed application'
' 10. Click 'Configure consent screen'
' 11. Fill in the 'Email address' field (select email address from dropdown box)
' 12. Fill in the 'Product name' field (can be anything)
' 13. Click 'Save'
' 14. Wait for the 'Create Client ID' screen to re-appear
' 15. Select 'Installed application' under 'Application type'
' 16. Select 'Other' under 'Installed application type'
' 17. Click 'Create Client ID'
' 18. Copy the key values: 'Client ID' and 'Client secret' into the strings below
' 19. Double-check that the copied values exactly match the values on the Developer Console (e.g. you didn't miss a character off the end).
'
'******* UNCOMMENT THE FOLLOWING TWO LINES AND INSERT YOUR CLIENT ID AND CLIENT SECRET **********
'Function getClientId()        As String : Return "insert your Client ID here" : End Function
'Function getClientSecret()    As String : Return "insert your Client Secret here" : End Function