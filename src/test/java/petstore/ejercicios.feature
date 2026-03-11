Feature: Ejercicios basicos
  Scenario: cp01 - login exitoso
    Given url 'https://petstore.swagger.io/v2'
    And path '/user/login'
    And param username = 'admin'
    And param password = '123456'
    When method get
    Then status 200

    Scenario: CP02 - Crear Orden
      Given url 'https://petstore.swagger.io/v2'
      And path '/store/order'
      And request
      """
      {
      "id": 0,
      "petId": 0,
      "quantity": 0,
      "shipDate": "2026-02-25T02:07:20.357Z",
      "status": "placed",
      "complete": true
    }
      """

      When method post
      Then status 200

  Scenario: CP03 - Crear usuario
    Given url 'https://petstore.swagger.io/v2'
    And path '/user'
    And request
    """
      {
          "id": 0,
      "username": "vivianalez",
      "firstName": "vivian",
      "lastName": "lezama",
      "email": "vivi@gmail.com",
      "password": "123453",
      "phone": "908173676",
      "userStatus": 0
    }
      """

    When method post
    Then status 200

    Scenario: CP04 - CREAR ORDEN VARIABLE
    * def <bodyOrder> =
       """
            {
            "id": 0,
            "petId": 0,
            "quantity": 0,
            "shipDate": "2026-02-25T02:07:20.357Z",
            "status": "placed",
            "complete": true
          }
            """
      Given url 'https://petstore.swagger.io/v2'
      And path '/store/order'
      * print response
      And request bodyOrder

      When method post
      Then status 200

      Scenario: cp06 - agregar mascota

        Given url 'https://petstore.swagger.io/v2'
        And path '/pet'
        And request
         """
            {
          "id": 111,
          "category": {
            "id": 0,
            "name": "conejo"
          },
          "name": "BomBom",
          "photoUrls": [
            "string"
          ],
          "tags": [
            {
              "id": 0,
              "name": "mestizo"
            }
          ],
          "status": "available"
        }
            """

When method post
        Then status 200
        And match response.category.name == 'conejo'
        And match response.name == 'BomBom'
        And match response.tags[0].name == 'mestizo'
        And assert response.status == 'available'

  Scenario: cp07 - buscar mascota por estado

    Given url 'https://petstore.swagger.io/v2'
    And path '/pet/findByStatus'
    And param status = "sold"


    When method get
    Then status 200
    * print response
    And match each response[*].id == '#number'
    And match each response[*].name == '#string'
    And match each response[*].status == 'sold'
