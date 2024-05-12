@clockify @prueba
Feature: Clockify - Practico de Clase

  Background:
    And base url $(env.base_url_clockify)
    And header x-api-key = MmY4ZmVjOGItMDEwMS00YjEzLWJiMTUtYWUxZGJiZWExMmJm

  @addWorkspace
  Scenario: Add Workspace
    Given endpoint v1/workspaces
    And header Content-Type = application/json
    And body jsons/bodies/addWokspace.json
    When execute method POST
    Then the status code should be 201

  @listWorkspace
  Scenario: Get all user of workspaces
    Given endpoint v1/workspaces
    When execute method GET
    Then the status code should be 200
    * define idWorkspace = response.[2].id

  @addClient @Ignore
  Scenario: Add Client to workspace
    Given endpoint v1/workspaces
    And execute method GET
    And the status code should be 200
    * define idWorkspace = response.[2].id
    And base url $(env.base_url_clockify)
    And header x-api-key = MmY4ZmVjOGItMDEwMS00YjEzLWJiMTUtYWUxZGJiZWExMmJm
    And header Content-Type = application/json
    And endpoint v1/workspaces/{{idWorkspace}}/clients
    And body jsons/bodies/addClient.json
    When execute method POST
    Then the status code should be 201
    And response should be name = "Client Roma"

  @addClientReuse
  Scenario: Add Client to workspace with reuse
    Given call Clockify.feature@listWorkspace
    And header Content-Type = application/json
    And endpoint v1/workspaces/{{idWorkspace}}/clients
    And body jsons/bodies/addClient.json
    When execute method POST
    Then the status code should be 201
    And response should be name = "Client Roma Coffee"

  @addClientReuse2
 Scenario Outline: Add Client to workspace with reuse
    Given call Clockify.feature@listWorkspace
    And endpoint v1/workspaces/{{idWorkspace}}/clients
    And header Content-Type = application/json
    And set value <nameClient> of key name in body jsons/bodies/addClient.json
    When execute method POST
    Then the status code should be 201
    And response should be name = <nameClient>

    Examples:
      | nameClient     |
      | Shopping Havan |

  @findClientOnWorkspace
  Scenario: Find Client on workspace with reuse
    Given call Clockify.feature@listWorkspace
    And endpoint v1/workspaces/{{idWorkspace}}/clients
    When execute method GET
    Then the status code should be 200
    * define idClient = response.[0].id

  @deleteClientOnWorkspace
  Scenario: Delete Client on workspace with reuse
    Given call Clockify.feature@findClientOnWorkspace
    And endpoint v1/workspaces/{{idWorkspace}}/clients/{{idClient}}
    When execute method DELETE
    Then the status code should be 200


