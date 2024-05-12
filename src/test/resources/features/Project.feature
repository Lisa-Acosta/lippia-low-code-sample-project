@clockify @project
Feature: Project - Practico 4
  Background:
    And base url $(env.base_url_clockify)
    And header x-api-key = MmY4ZmVjOGItMDEwMS00YjEzLWJiMTUtYWUxZGJiZWExMmJm

  @listWorkspace
  Scenario: Get all Workspaces
    Given endpoint v1/workspaces
    When execute method GET
    Then the status code should be 200
    * define idWorkspace = response.[2].id

  @addProject
  Scenario Outline: Add Project on workspace exitoso
    Given call Project.feature@listWorkspace
    And header Content-Type = application/json
    And endpoint v1/workspaces/{{idWorkspace}}/projects
    And set value <nameProject> of key name in body jsons/bodies/addProject.json
    When execute method POST
    Then the status code should be 201
    And response should be name = <nameProject>

    Examples:
      | nameProject          |
      | Api Low Code Project |

  @listProjects
  Scenario: Get all Projects
    Given call Project.feature@listWorkspace
    And header Content-Type = application/json
    And endpoint v1/workspaces/{{idWorkspace}}/projects
    When execute method GET
    Then the status code should be 200
    * define idProject = response.[0].id

  @findProject
  Scenario: Find Project by ID
    Given call Project.feature@listProjects
    And header Content-Type = application/json
    And endpoint v1/workspaces/{{idWorkspace}}/projects/{{idProject}}
    When execute method GET
    Then the status code should be 200
    And response should be name = "Api Low Code Project"


  Scenario: Update Project template
    Given call Project.feature@listProjects
    And header Content-Type = application/json
    And endpoint v1/workspaces/{{idWorkspace}}/projects/{{idProject}}/memberships
    And body jsons/bodies/memberships.json
    When execute method PATCH
    Then the status code should be 200
    And response should be name = "Api Low Code Project"
    * validate response should be memberships[0].hourlyRate.amount = "0"












