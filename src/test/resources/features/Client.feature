@clockify @client
Feature: Client

  Background:
    And base url $(env.base_url_clockify)
    And header x-api-key = MmY4ZmVjOGItMDEwMS00YjEzLWJiMTUtYWUxZGJiZWExMmJm

  @addClient
 Scenario Outline: Add Client to workspace
    Given call Workspace.feature@listWorkspace
    And endpoint v1/workspaces/{{idWorkspace}}/clients
    And header Content-Type = application/json
    And set value <nameClient> of key name in body jsons/bodies/addClient.json
    When execute method POST
    Then the status code should be 201
    And response should be name = <nameClient>

    Examples:
      | nameClient     |
      | Shopping Havan |

  @getClients
  Scenario: Get Client on workspace
    Given call Workspace.feature@listWorkspace
    And endpoint v1/workspaces/{{idWorkspace}}/clients
    When execute method GET
    Then the status code should be 200
    * define idClient = response.[0].id

  @findClient
  Scenario: Find Client on workspace
    Given call Client.feature@getClients
    And endpoint v1/workspaces/{{idWorkspace}}/clients/{{idClient}}
    When execute method GET
    Then the status code should be 200
    And response should be name = "Shopping Havan"


  @deleteClient
  Scenario: Delete Client on workspace
    Given call Client.feature@getClients
    And endpoint v1/workspaces/{{idWorkspace}}/clients/{{idClient}}
    When execute method DELETE
    Then the status code should be 200


