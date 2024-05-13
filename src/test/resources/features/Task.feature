@task @regression
Feature: Task
  Background:
    And base url $(env.base_url_clockify)
    And header x-api-key = MmY4ZmVjOGItMDEwMS00YjEzLWJiMTUtYWUxZGJiZWExMmJm
    And header Content-Type = application/json

  @smoke
  Scenario Outline: Add new task on project
    Given call Project.feature@listProjects
    And endpoint v1/workspaces/{{idWorkspace}}/projects/{{idProject}}/tasks
    And set value <nameTask> of key name in body jsons/bodies/addTask.json
    When execute method POST
    Then the status code should be 201
    And response should be name = <nameTask>

    Examples:
      | nameTask          |
      | Api Low Code Task |

  @smoke
  Scenario: Add existing Task failed
    Given call Project.feature@listProjects
    And endpoint v1/workspaces/{{idWorkspace}}/projects/{{idProject}}/tasks
    And body jsons/bodies/addTask.json
    When execute method POST
    Then the status code should be 400


  @listTask @smoke
  Scenario: Get all Task
    Given call Project.feature@listProjects
    And endpoint v1/workspaces/{{idWorkspace}}/projects/{{idProject}}/tasks
    When execute method GET
    Then the status code should be 200
    * define idTask = response.[0].id

  @updateTask
  Scenario: Update Task on Project
    Given call Task.feature@listTask
    And endpoint v1/workspaces/{{idWorkspace}}/projects/{{idProject}}/tasks/{{idTask}}
    And body jsons/bodies/updateTask.json
    When execute method PUT
    Then the status code should be 200
    And response should be name = "Api Low Code Task"

  Scenario: Update Task failed -
    Given call Task.feature@listTask
    And endpoint v1/workspaces/{{idWorkspace}}/projects/{{idProject}}/tasks/{{idTask}}
    And body jsons/bodies/updateTask.json
    When execute method GET
    Then the status code should be 200
    And response should be name = "Api Low Code Task"

  @smoke
  Scenario: Delete Task on Project
    Given call Task.feature@listTask
    And endpoint v1/workspaces/{{idWorkspace}}/projects/{{idProject}}/tasks/{{idTask}}
    When execute method DELETE
    Then the status code should be 200

  @smoke
  Scenario: Add Task failed -wrong endpoint
    Given call Project.feature@listProjects
    And endpoint v1/workspaces/{{idWorkspace}}/projects/{{idProject}}
    And body jsons/bodies/addTask.json
    When execute method POST
    Then the status code should be 405













