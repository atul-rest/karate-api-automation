
Feature: Add Likes

Background: Define URL
    * url apiUrl 

Scenario: Add Likes
    Given path 'articles' ,slug, 'favorite'
    And request {}
    When method Post
    Then status 200
    * def likesCount = response.article.favoritesCount
