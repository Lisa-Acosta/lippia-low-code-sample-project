@client @regression
Feature: Client

  Background:
    And base url $(env.base_url_clockify)
    And header x-api-key = MmY4ZmVjOGItMDEwMS00YjEzLWJiMTUtYWUxZGJiZWExMmJm

  @smoke
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

  @smoke
  Scenario: Add existing Client failed
    Given call Workspace.feature@listWorkspace
    And endpoint v1/workspaces/{{idWorkspace}}/clients
    And header Content-Type = application/json
    And body jsons/bodies/addClient.json
    When execute method POST
    Then the status code should be 400

  @listClients @smoke
  Scenario: Get Client on workspace
    Given call Workspace.feature@listWorkspace
    And endpoint v1/workspaces/{{idWorkspace}}/clients
    When execute method GET
    Then the status code should be 200
    * define idClient = response.[0].id

  @findClient
  Scenario: Find Client on workspace
    Given call Client.feature@listClients
    And endpoint v1/workspaces/{{idWorkspace}}/clients/{{idClient}}
    When execute method GET
    Then the status code should be 200
    And response should be name = "Shopping Havan"

  @deleteClient @smoke
  Scenario: Delete Client on workspace
    Given call Client.feature@findClient
    And endpoint v1/workspaces/{{idWorkspace}}/clients/{{idClient}}
    When execute method DELETE
    Then the status code should be 200

  @smoke
  Scenario: Add Client failed - wrong endpoint
    Given call Workspace.feature@listWorkspace
    And endpoint v1/workspaces/{{idWorkspace}}
    And header Content-Type = application/json
    And body jsons/bodies/addClient.json
    When execute method POST
    Then the status code should be 405








