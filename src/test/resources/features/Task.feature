@clockify @task
Feature: Task
  Background:
    And base url $(env.base_url_clockify)
    And header x-api-key = MmY4ZmVjOGItMDEwMS00YjEzLWJiMTUtYWUxZGJiZWExMmJm

  @addTask
  Scenario Outline: Add new task on project
    Given call Project.feature@listProjects
    And header Content-Type = application/json
    And endpoint v1/workspaces/{{idWorkspace}}/projects/{{idProject}}/tasks
    And set value <nameTask> of key name in body jsons/bodies/addTask.json
    When execute method POST
    Then the status code should be 201
    And response should be name = <nameTask>

    Examples:
      | nameTask          |
      | Api Low Code Task |

  @listTask
  Scenario: Get all Task
    Given call Project.feature@listProjects
    And header Content-Type = application/json
    And endpoint v1/workspaces/{{idWorkspace}}/projects/{{idProject}}/tasks
    When execute method GET
    Then the status code should be 200
    * define idTask = response.[0].id

  @updateTask
  Scenario: Update Task on Project
    Given call Task.feature@listTask
    And header Content-Type = application/json
    And endpoint v1/workspaces/{{idWorkspace}}/projects/{{idProject}}/tasks/{{idTask}}
    And body jsons/bodies/updateTask.json
    When execute method PUT
    Then the status code should be 200
    And response should be name = "Api Low Code Task"

  @prueba
  Scenario: Delete Task on Project
    Given call Task.feature@listTask
    And header Content-Type = application/json
    And endpoint v1/workspaces/{{idWorkspace}}/projects/{{idProject}}/tasks/{{idTask}}
    When execute method DELETE
    Then the status code should be 200













