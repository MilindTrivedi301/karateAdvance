
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


        # Scenario: Validate Sign Up error message using Data driven
        # * def randomEmail = dataGenerator.getRandomEmail()
        # * def randomUsername = dataGenerator.getRandomUsername()

        # Given path 'users'
        # And request 
        # """
        #     {
        #     user: 
        #     {
        #         "email": "test7568@test.com", 
        #         "password": "Mtech123", 
        #         "username": "#(randomUsername)"
        #         }
        # }
        # """

        # When method post
        # Then status 422


        Scenario Outline: Validate Sign Up error message using Data driven 
        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUsername = dataGenerator.getRandomUsername()

        Given path 'users'
        And request 
        """
            {
            user: 
            {
                "email": "<email>", 
                "password": "<password>", 
                "username": "<username>"
                }
        }
        """

        When method post
        Then status 422
        And match response == <errorResponse>       //assertion to match the responce and error message

        Examples: 
                Examples: 
                |  email                    |   password            |   username                      |   errorResponse                                                                             |
                |  #(randomEmail)           |   Mtech123            |   test7568                      |   {"errors":{"username":["has already been taken"]}}                                        |
                |  test7568@test.com        |   Mtech123            |   #(randomUsername)             |   {"errors":{"email":["has already been taken"]}}                                           |
                |  test7568                 |   Mtech123            |   #(randomUsername)             |   {"errors":{"email":["has already been taken"]}}                                           |
                # |  #(randomEmail)           |   Mtech123            |   test75683243243243242343      |   {"errors":{"username":["is too long (maximum is 20 characters)"]}}                        |
                # |  #(randomEmail)           |   Mt                  |   #(randomUsername)             |   {"errors":{"password":["is too short (minimum is 8 characters)"]}}                        |
                # |                           |   Mtech123            |   #(randomUsername)             |   {"errors":{"email":["Can't be blank"]}}                                                   |
                # |  #(randomEmail)           |                       |   #(randomUsername)             |   {"errors":{"password":["Can't be blank"]}}                                                |
                # |  #(randomEmail)           |   Mtech123            |                                 |   {"errors":{"username":["Can't be blank","is too short (minimum is 1 characters)"]}}       |