Feature: Flujo Auth
  Scenario: CP01-Create token ok

    Given url "https://restful-booker.herokuapp.com"
    And path "/auth"
    And request { "username" : "admin", "password" : "password123"}
    When method post
    Then status 200
    And match response.token == "#string"

  Scenario Outline: CP02-<nombre>-NOK

    Given url "https://restful-booker.herokuapp.com"
    And path "/auth"
    And request { "username" : <username>, "password" : <password>}
    When method post
    Then status 200
    And match response.reason == "Bad credentials"

    Examples:

    |username|password|nombre|
    |admin|password000|Contraseña incorrecta|
    |Carlos|password123|Usuario incorrecto|

    @token-parameter
  Scenario: CP01-Create token ok

    Given url "https://restful-booker.herokuapp.com"
    And path "/auth"
    And request { "username" : #(user), "password" : #(pass)}
    When method post
    Then status 200
    And match response.token == "#string"


