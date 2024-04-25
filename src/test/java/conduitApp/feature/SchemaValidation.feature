@ignore
Feature: Test for the home page

Background: Define url
    Given url apiUrl

    Scenario: Get all the tags
        Given path 'tags'
        When method GET
        Then status 200
        And match response.tags contains ['Zoom', 'Coding']
        And match response.tags !contains 'truck'
        And match response.tags contains any ['Git', 'GitHub88', 'Test88']
        And match response.tags == '#array'
        And match each response.tags == '#string'

    Scenario: Get the 10 articles from the page using param
        * def timeValidator = read('classpath:helpers/timeValidator.js')
        
        Given path 'articles'
        Given params { limit: 10, offset: 0}
        When method GET
        Then status 200
        And match response == {"articles": "#[10]", "articlesCount": 17}
        And match each response.articles ==
        """
            {
            "slug": "#string",
            "title": "#string",
            "description": "#string",
            "body": "#string",
            "tagList": "#array",
            "createdAt": "#? timeValidator(_)",
            "updatedAt": "#? timeValidator(_)",
            "favorited": "#boolean",
            "favoritesCount": "#number",
            "author": {
                "username": "#string",
                "bio": "##string",
                "image": "#string",
                "following": "#boolean"
            }
        }
        """