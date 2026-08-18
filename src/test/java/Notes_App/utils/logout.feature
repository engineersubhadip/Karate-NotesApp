Feature: We will log-out from the current session


  Scenario: Log-out current session
    # * If the user calls the log-out functionality without logging in to the app, we will make sure, we first login, capture the token and use the same token to log-out. Approach has been taken, so that the client does not gets confused, while calling this feature independently
    * def currentToken = (typeof token === 'undefined') ? currentToken = karate.call('classpath:Notes_App/utils/login.feature').userToken : currentToken = token
    * def logoutURL = baseURL + logoutEndPoint
    * header x-auth-token = currentToken
    Given url logoutURL
    When method Delete
    Then status 200
    * print 'User logs out of the session...'