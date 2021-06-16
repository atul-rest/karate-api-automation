@debug
Feature: Sign up new user

Background: Preconditions
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * def timeValidator = read('classpath:helpers/timeValidator.js')
    * def randomEmail = dataGenerator.getRandomEmail()
    * def randomUsername = dataGenerator.getRandomUsername()
    * url apiUrl


Scenario: New user sign up
    Given path 'users'
    And request
    """
        {
            "user": {
                "email": #(randomEmail),
                "password": "karate123",
                "username": #(randomUsername)
            }
        }
    """    
    When method Post
    Then status 200
    And match response == 
    """
        {
            "user": {
                "id": "#number",
                "email": #(randomEmail),
                "createdAt": "#? timeValidator(_)",
                "updatedAt": "#? timeValidator(_)",
                "username": #(randomUsername),
                "bio": null,
                "image": null,
                "token": "#string"
            }
        }
    """

Scenario Outline: Validate sign up error messages
    Given path 'users'
    And request
    """
        {
            "user": {
                "email": "<email>",
                "password": "<password>",
                "username": "<username>"
            }
        }
    """    
    When method Post
    And status 422
    And match response == <errorResponse>
    
    Examples:
    | email              | password  | username               | errorResponse                                                                      |
    | #(randomEmail)     | Karate123 | KarateUser720          | {"errors":{"username":["has already been taken"]}}                                 |
    | karate725@test.com | Karate123 | #(randomUsername)      | {"errors":{"email":["has already been taken"]}}                                    |
    | #(randomEmail)     | Karate123 | KarateUser725725725725 | {"errors":{"username":["is too long (maximum is 20 characters)"]}}                 |
    | karate730          | Karate123 | #(randomUsername)      | {"errors":{"email":["is invalid"]}}                                                |
    | #(randomEmail)     | Kar       | #(randomUsername)      | {"errors":{"password":["is too short (minimum is 8 characters)"]}}                 |
    |                    | Karate123 | #(randomUsername)      | {"errors":{"email":["can't be blank"]}}                                            |
    | #(randomEmail)     | Karate123 |                        | {"errors":{"username":["can't be blank","is too short (minimum is 1 character)"]}} |
    | #(randomEmail)     |           | #(randomUsername)      | {"errors":{"password":["can't be blank"]}}                                         |