
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

    * def sleep = function(ms){ java.lang.Thread.sleep(ms) }
    * def pause = karate.get('__gatling.pause', sleep)

    
Scenario: Create and Delete Article
    Given path 'articles'
    And request articleRequestBody
    When method Post
    Then status 200
    * def articleId = response.article.slug

    * pause(5000)

    Given path 'articles',articleId
    When method Delete
    Then status 200