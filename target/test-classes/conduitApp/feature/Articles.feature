
Feature: Articles post request

Background: Define url
    Given url apiUrl
    # * def tokenResponse = callonce read('classpath:helpers/CreateToken.feature') 
    # * def token =  tokenResponse.authToken


    # Scenario: Create a new artcile
    #     Given path 'articles'
    #     And request {"article": {"title": "hello world1", "description": "test_karate", "body": "test", "tagList": ["newkarate"]}}
    #     When method post
    #     Then status 201

    Scenario: Create new article and delte the same crated arcticle using karate tool

        # Given header Authorization = 'Token ' + token
        Given path 'articles'
        And request {"article": {"title": "Delete1 article ", "description": "testnew_karate", "body": "test karate request", "tagList": ["posthello_karate"]}}
        When method post
        Then status 201
        * def articleId = response.article.slug
        
        Given params { limit 10, offset:0} 
        Given path 'articles'
        When method GET
        Then status 200
    
        # Given header Authorization = 'Token ' + token
        Given path 'articles',articleId
        When method delete
        Then status 204

        Given params { limit 10, offset:0} 
        Given path 'articles'
        When method GET
        Then status 200
        And match response.articles[0].title != 'Delete1 article'
