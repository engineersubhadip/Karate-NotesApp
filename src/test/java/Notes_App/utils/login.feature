Feature: We will be logging in to the app and capture the token

   Scenario: Login to Notes App
      * def loginURL = baseURL + loginEndPoint
      * def userCreds = {email: '#(email)', password: '#(password)'}
      Given url loginURL
      And request userCreds
      When method Post
      Then status 200
      * def userToken = response.data.token
      * print 'The user token -> ', userToken