# Asana team workload balancer

This use case demonstrates how to automate the onboarding process of new employees using Asana. Automating the employee onboarding process in Asana can significantly improve the efficiency and consistency of welcoming new team members. 

This example involves creating a new project for each new hire, populating it with a series of tasks that need to be completed as part of the onboarding process, and assigning those tasks to the appropriate team members or departments (e.g., IT for equipment setup, and HR for documentation).

## Prerequisites

### 1. Setup Asana account

Refer to the [Setup guide](https://central.ballerina.io/ballerinax/asana/latest#setup-guide) to obtain an Asana personal access token, if you do not have one.

### 2. Configuration

Update the following configurations in the `Config.toml` file in the example root directory:

```toml
authToken = "<auth_token>"
workspaceId = "<workspace_id"
teamId = "<team_id>"
newEmployeeName = "<employee_name>"
```

## Run the example

Execute the following command to run the example:

```ballerina
bal run
```
