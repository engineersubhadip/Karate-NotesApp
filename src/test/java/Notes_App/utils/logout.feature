Feature: We will log-out from the current session

  @Debug
  Scenario: Log-out current session
    * def currentToken = (typeof token === 'undefined') ? currentToken = karate.call('classpath:Notes_App/utils/login.feature').userToken : currentToken = token
    * def logoutURL = baseURL + logoutEndPoint
    * header x-auth-token = currentToken
    Given url logoutURL
    When method Delete
    Then status 200
