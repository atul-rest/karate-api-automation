
Feature: Hooks

Background: hooks
  
    # call = Before each
    # callonce = Before (Karate uses cached value)
    # * def result = callonce read('classpath:helpers/Dummy.feature') 
    # * def username = result.randomUsername

    #after hooks
    * configure afterScenario = function(){ karate.call('classpath:helpers/Dummy.feature') }
    * configure afterFeature =
    """
        function(){
            karate.log('After Feature Text');
        }
    """

Scenario: First scenario
    # * print username
    * print 'This is first scenario'

Scenario: Second Scenario
    # * print username
    * print 'This is second scenario'