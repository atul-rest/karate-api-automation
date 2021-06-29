# Web Service Testing With Karate

## Pre-Installations Required:
1. [Java 8 or higher version](https://www.oracle.com/java/technologies/javase-downloads.html)
2. [GIT](https://git-scm.com/downloads)
3. [Maven (Installation and setup)](https://mkyong.com/maven/how-to-install-maven-in-windows/)
4. [IntelliJ IDEA](https://www.jetbrains.com/idea/download/#section=windows) or [Visual Studio Code](https://code.visualstudio.com/download)
5. [Postman](https://www.postman.com/downloads/)

Optional:
- [NodeJS](https://nodejs.org/en/download/)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-windows.html)

## Running in VSC then install below plugins:
- Cucumber full support
- Karate Runner
- Jave extension pack

## Running in IntelliJ
If you use IntelliJ IDEA, Cucumber support is built-in, and you can even select a single Scenario within a Feature to run at a time. If you are using the free Community Edition, you can easily install the "Gherkin" and "Cucumber for Java" plugins.

## Project Setup
I created my Karate project using the Maven archetype since I am quite familiar with Maven. I named my project "karate-api-automation":

mvn archetype:generate \
  -DarchetypeGroupId=com.intuit.karate \
  -DarchetypeArtifactId=karate-archetype \
  -DarchetypeVersion=0.9.0 \
  -DgroupId=com.karateautomation \
  -DartifactId=karate-api-automation
  
## Resources
- The Karate GitHub project
- REST API Testing with Karate (Baeldung)
- Karate a Rest Test Tool – Basic API Testing (Joe Colantonio)
- Karate framework: REST API testing made easy! (Mohammed Aboullaite)
  
 










