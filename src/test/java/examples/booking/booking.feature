Feature: Booking

  Scenario: CP01 Filter  booking
    Given url "https://restful-booker.herokuapp.com"
    And path "booking"
    And request { checkin: "2018-06-01", checkout: "2026-06-30"}
    When method get
    Then status 200

  Scenario: CP02 Ejemplo 2
    Given url "https://restful-booker.herokuapp.com"
    And path "booking"
    And params { firstname: "sally", lastname: "brown"}
    When method get
    Then status 200

  Scenario Outline: CP03 Ejemplo 3
    Given url "https://restful-booker.herokuapp.com"
    And path "booking"
    And param firstname = '<firstname>'
    And param lastname = '<lastname>'
    When method get
    Then status 200

    Examples:

    |firstname|lastname|
    |Jin|Paredes|
    |Susan|Castro|

    Scenario: cp05-getbookingId-ok
      * def id = 1
      Given url "https://restful-booker.herokuapp.com"
      And path "booking/" + id
      When method get
      Then status 200


