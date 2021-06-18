
Feature: Dummy

Scenario: Dummy Scenario
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * def randomUsername = dataGenerator.getRandomUsername()
    * print randomUsername