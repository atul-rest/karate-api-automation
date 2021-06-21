
Feature: Home Work

Background: Preconditions
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * def timeValidator = read('classpath:helpers/timeValidator.js')
    * def randomComment = dataGenerator.getRandomComment()
    * url apiUrl


Scenario: Favourite Articles
    Given params { limit: 10, offset: 0 }
    Given path 'articles'
    When method Get
    Then status 200
    * def articleId = response.articles[0].slug
    * def favoritesCount = response.articles[0].favoritesCount
    * print articleId
    * print "=================="+favoritesCount

    Given path 'articles' ,articleId, 'favorite'
    When method Post
    Then status 200
    And match response ==
    """
        {
            "article": {
                        "title": "#string",
                        "slug": "#string",
                        "body": "#string",
                        "createdAt": "#? timeValidator(_)",
                        "updatedAt": "#? timeValidator(_)",
                        "tagList": "#array",
                        "description": "#string",
                        "author": {
                            "username": "#string",
                            "bio": "##array",
                            "image": "#string",
                            "following": '#boolean'
                        },
                        "favorited": '#boolean',
                        "favoritesCount": '#number'
                    }
        }
    """
    * def initialCount = 0 //set initial count to 0
    * def response = {"favoritesCount": 1} //this is new response that we get from above post method
    And match response.favoritesCount == initialCount + 1 //compare the intial count and new count and count is incremented by 1
    # And match response.article.favoritesCount == favoritesCount + 1
    * print response.favoritesCount

    Given params { favorited: KarateAPIAutomation, limit: 10, offset: 0 }
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[*].slug contains articleId


Scenario: Comment articles
    Given params { limit: 10, offset: 0 }
    Given path 'articles'
    When method Get
    Then status 200
    * def slugId = response.articles[0].slug
    * print slugId

    Given path 'articles' ,slugId, 'comments'
    When method Get
    Then status 200
    And match response ==
    """
        {
            "comments": "##array"
        }
    """
    * def commentsCount = response.comments.length
    * print "---------------------"+commentsCount

    Given path 'articles' ,slugId, 'comments'
    And request
    """
        {
            "comment": {
                "body": #(randomComment)
            }
        }
    """
    When method Post
    Then status 200
    And match response ==
    """
        {
            "comment": {
                "id": '#number',
                "createdAt": "#? timeValidator(_)",
                "updatedAt": "#? timeValidator(_)",
                "body": #(randomComment),
                "author": {
                    "username": "#string",
                    "bio": "##array",
                    "image": "#string",
                    "following": '#boolean'
                }
            }
        }
    """
    Given path 'articles' ,slugId, 'comments'
    When method Get
    Then status 200
    * def GetCommentsCount = response.comments.length
    * def commentId = response.comments[0].id
    * print "==========="+GetCommentsCount
    * print "==========="+commentsCount
    And match GetCommentsCount == commentsCount + 1

    Given path 'articles/'+slugId+'/comments/'+commentId
    When method Delete
    Then status 200

    Given path 'articles' ,slugId, 'comments'
    When method Get
    Then status 200
    * def GetCommentsCountAfterDelete = response.comments.length
    * print "=============="+GetCommentsCountAfterDelete
    And match GetCommentsCountAfterDelete == GetCommentsCount - 1













    





