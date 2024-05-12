@clockify @workspace
Feature: Workspace
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
  Scenario: Get all Workspaces
    Given endpoint v1/workspaces
    When execute method GET
    Then the status code should be 200
    * define idWorkspace = response.[1].id











