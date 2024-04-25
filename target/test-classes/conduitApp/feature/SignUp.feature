
Feature: Sign Up new feature

    Background: Preconditions
        * def dataGenerator = Java.type('helpers.dataGenerator')
        Given url apiUrl
    Scenario: New user Sign Up
        # Given def userData = {"email": "test_user7568@test.com", "username": "test_user7568"}

        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUsername = dataGenerator.getRandomUsername()

        Given path 'users'
        # And request {user: {"email": "test7568@test.com", "password": "Mtech123", "username": "test7568"}}
        # And request {user: {"email": "#(userData.email)", "password": "Mtech123", "username": "#(userData.username)"}}    
        # And request {user: {"email": "#('new'+userData.email)","password": "Mtech123","username": "#('newuser'+userData.username)"}}
        
        And request 
        """
            {
            user: 
            {
                "email": "#(randomEmail)", 
                "password": "Mtech123", 
                "username": "#(randomUsername)"
                }
        }
        """
        
        When method post
        Then status 201
        And match response == 
        """
            {
                "user": {
                    "id": "#number",
                    "email": #(randomEmail),
                    "username": #(randomUsername),
                    "bio": null,
                    "image": "#string",
                    "token": "#string"
                }
            }
        """