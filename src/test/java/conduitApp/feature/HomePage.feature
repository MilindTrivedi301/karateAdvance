
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
        Given path 'articles'
        Given params { limit: 10, offset: 0}
        When method GET
        Then status 200
        And match response.articles == '#[10]'
        And match response.articlesCount == 19 //to find the total counts
        And match response == {"articles": "#array", "articlesCount": 19}  //to find the count and the objests
        And match response.articles[0].createdAt contains '2024'  //to find the certain part([0] is used to find index value of the array) of the string
        And match response.articles[*].favoritesCount contains 0  //to find through all(* is used for that) the values(arrays) to see the specific value (favoritesCount= 1)
        And match response.articles[*].author.bio contains null  //to find through all(* is used for that) the null value
        And match response..bio contains null  //to find through all(.. is used for redirect to path) the null value
        And match each response..following == false  //to find through that each value is false/true(each is used to look into each object) (if any one of them is true then it will throw an error)