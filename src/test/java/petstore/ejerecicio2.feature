Feature: Request and Response

  Scenario: CP01 - Actualizar mascota
    Given url "https://petstore.swagger.io/v2"
    And path "/pet"
    And request read('bodyPet.json')


    Scenario:  CP03- CREATE TOKEN
      Given url 'https://restful-booker.herokuapp.com'
      And path '/auth'
      And header Content-Type = 'application/json'
      And request { username: "admin", password: "password123"}
      When method post
      Then status 200
      And match $.token == '#string'
      And match responseType == 'json'

      Scenario: CP04 : Actualizar mascota id
        * def paramPet = read('parameterPet.json')
        Given url "https://petstore.swagger.io/v2"
        And path '/pet/'+ paramPet.id
        And form field name = paramPet.name
        And form field status = paramPet.status
        When method post
        Then status 200
        And match $.message == paramPet.id


