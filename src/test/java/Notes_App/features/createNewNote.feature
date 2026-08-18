Feature: This feature file will contains all the scenarios related to creation of new note

   Background: Preconditions
      * def token = call read('classpath:Notes_App/utils/login.feature')
      * def authToken = token.userToken
      # * Lets logout from the current session [To be ran after every scenario]
      * configure afterScenario =
         """
         function() {
         karate.call('classpath:Notes_App/utils/logout.feature', {token : authToken})
         }
         """

   @Debug
   Scenario Outline: User successfully creates a new note
      * def createNewNoteURL = baseURL + createNewNoteEndPoint
      Given url createNewNoteURL
      And header x-auth-token = authToken
      And request
         """
         {
         title : '<current_title>',
         description : '<current_description>',
         category : '<current_category>'
         }
         """
      When method Post
      Then match responseStatus == <expected_status>
      Examples:
         | current_title | current_description | current_category | expected_status |
         | title1        | description1        | Home             | 200             |
         | title2        | description2        | Work             | 200             |
         | title3        | description3        | Personal         | 200             |