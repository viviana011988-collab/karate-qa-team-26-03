Feature: Casos dinamicos

  Background:
    * def responsetoken = call read ('classpath:examples/booking/auth.feature@token-parameter') {user: "admin", pass:"password123"}
    * print responsetoken
    * def authtoken = "token=" + responsetoken.token
    Given url "https://restful-booker.herokuapp.com"


  Scenario: CP01 - Partial update booking
    * def id = 1

    And path "booking/"+id
    And headers {Content-Type:"application/json", Accept="application/json", Cookie: #(authtoken)}
    And request {"firstname": "James", "lastname": "brown"}
    When method PATCH
    Then status 200

    Scenario Outline: CP02-Data dinamica csv
      And path "booking"
      And request
      """
      "firstname" : <firstname>,
      "lastname" : <lastname>,
      "totalprice" : <totalprice>,
      "depositpaid" : true,
    "bookingdates" : {
        "checkin" : "2018-01-01",
        "checkout" : "2019-01-01"
    },
    "additionalneeds" : "Breakfast"
    }

      """
      When method post
      Then status 200

      Examples:
      |read('data.csv'|


  Scenario Outline: CP03 BookingID
    Given url "https://restful-booker.herokuapp.com"
    * def id = 1

    And path "booking/" + id
    And param firstname = '<firstname>'
    And param lastname = '<lastname>'
    When method get
    Then status 200

    Examples:

      |firstname|lastname|
      |Jin|Paredes|
      |Susan|Castro|

Scenario Outline: CP08 - Data Dinamica
  And path "booking"
  And request read('data-driven.json')
  When method post
  Then status 418

  Examples:
    |firstname|lastname| totalprice | depositpaid |
    |Jin      |Paredes | 1234    | true
    |Susan    |Castro  |2344   |true