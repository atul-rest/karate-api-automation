@parallel=false
Feature: Articles

    Background: Define URL
        * url apiUrl
        * def articleRequestBody = read('classpath:ConduitApp/json/newArticleRequest.json')
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * def articleValues = dataGenerator.getRandomArticleValues()        
        * def articleTitle = articleValues.title
        * def articleDescription = articleValues.description
        * def articleBody = articleValues.body
        * set articleRequestBody.article.title = articleTitle
        * set articleRequestBody.article.description = articleDescription
        * set articleRequestBody.article.body = articleBody
   
    Scenario: Create a new article
        Given path 'articles'
        And request articleRequestBody
        When method Post
        Then status 200
        And match response.article.title == articleRequestBody.article.title

        
    Scenario: Create and Delete Article
        Given path 'articles'
        And request articleRequestBody
        When method Post
        Then status 200
        * def articleId = response.article.slug

        Given params { limit: 10, offset: 0 }
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title == articleRequestBody.article.title

        Given path 'articles',articleId
        When method Delete
        Then status 200

        Given params { limit: 10, offset: 0 }
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title != articleRequestBody.article.title
