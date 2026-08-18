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
      * def common = karate.call('classpath:Notes_App/utils/common.js')
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
      * def expectedResponse = {responseCode : '<responseCode>'}
      Then common.validateResponse(expectedResponse)
      Then match response.data.title == '<current_title>'
      Then match response.data.description == '<current_description>'
      Then match response.data.category == '<current_category>'

      Examples:
         | current_title | current_description | current_category | responseCode |
         | title1        | description1        | Home             | 200          |
         | title2        | description2        | Work             | 200          |
         | title3        | description3        | Personal         | 200          |


   Scenario Outline: Negative scenarrio : <current_scneario>
      * def common = karate.call('classpath:Notes_App/utils/common.js')
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
      * def expectedResponse = {responseCode : '<responseCode>', responseDescription : '<responseDescription>'}
      Then common.validateResponse(expectedResponse)
      Examples:
         | current_scneario                                                        | current_title | current_description | current_category | responseCode | responseDescription                                          |
         | user is trying to create a note, by passing empty title                 |               | valid description   | Home             | 400          | Title must be between 4 and 100 characters                   |
         | user is trying to create a note, by passing title having length 3       | ter           | valid description   | Home             | 400          | Title must be between 4 and 100 characters                   |
         | user is trying to create a note, by passing empty description           | valid title   |                     | Home             | 400          | Description must be between 4 and 1000 characters            |
         | user is trying to create a note, by passing description having length 3 | valid title   | des                 | Home             | 400          | Description must be between 4 and 1000 characters            |
         | user is trying to create a note, by passing empty category              | valid title   | valid description   |                  | 400          | Category must be one of the categories: Home, Work, Personal |
         | user is trying to create a note, by passing category having length 3    | valid title   | valid description   | val              | 400          | Category must be one of the categories: Home, Work, Personal |
         | user is trying to create a note, by passing invalid category value      | valid title   | valid description   | Laptop           | 400          | Category must be one of the categories: Home, Work, Personal |