Feature: We will be logging in to the app and capture the token

   @Debug
   Scenario: Login to Notes App
      * def loginURL = baseURL + loginEndPoint
      * print 'The final login url -> ', loginURL