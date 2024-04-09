## Overview

[Asana](https://asana.com/) is a popular project management and team collaboration tool that enables teams to organize, track, and manage their work and projects. It offers features such as task assignments, project milestones, team dashboards, and more, facilitating efficient workflow management.

This Ballerina connector is designed to interface with [Asana's REST API](https://developers.asana.com/reference/rest-api-reference), enabling programmatic access to Asana's services. It allows developers to automate tasks, manage projects, tasks, teams, and more, directly from Ballerina applications.

## Setup guide

To use the Asana Connector in Ballerina, you must have an Asana account and a Personal Access Token (PAT) or OAuth2 credentials for authentication. 

If you already have an Asana account, you can integrate the connector with your existing account. If not, you can create a new Asana account by visiting [Asana's Sign Up page](https://asana.com/) and following the registration process. 
Once you have an Asana account, you can proceed to create a PAT or set up OAuth2.

### Step 1: Access Asana developer console

1. Log in to your Asana account.
2. After logging in, navigate to the [Asana developer console](https://app.asana.com/0/my-apps).
3. Click on the **+ Create new token** button.

   <img src=https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-asana/master/docs/setup/resources/1-developer-console.png alt="Asana Developer Console" style="width: 80%;">

### Step 2: Create a new access token

1. Provide a name for the token and accept Asana's API terms checkbox after reading them.
2. Click on the **Create token** button.

   <img src=https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-asana/master/docs/setup/resources/2-create-token.png alt="Generate new PAT" style="width: 80%;">

3. Copy the generated token and keep it secure. You will need this token to authenticate the Asana connector.

   <img src=https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-asana/master/docs/setup/resources/3-copy-token.png alt="Copy PAT" style="width: 80%;">

## Quickstart

To use the `Asana` connector in your Ballerina application, modify the `.bal` file as follows:

### Step 1: Import the connector

Import the `ballerinax/asana` package into your Ballerina project.

```ballerina
import ballerinax/asana;
```

### Step 2: Instantiate a new connector

Create an `asana:ConnectionConfig` with the obtained PAT (or OAuth2) credentials and initialize the connector with it.

```ballerina
asana:ConnectionConfig asanaConfig = {
    auth: {
        token: authToken
    }
};

asana:Client asana = check new (asanaConfig);
```

### Step 3: Invoke the connector operation

Now, utilize the available connector operations.

#### Get all projects for the authenticated user

```ballerina
record {asana:ProjectCompact[] data?;} projects = check asana->/projects();
```

#### Create a new task in a project

```ballerina
asana:Tasks_body taskReq = {
    data: {
        name: "Email Marketing Campaign",
        notes: "Create a new email marketing campaign for the upcoming product launch.",
        workspace: "<workspaceId>",
        projects: ["<projectId>"]
    }
};

record {asana:TaskResponse data?;} taskCreated = check asana->/tasks.post(taskReq);
```

## Examples

The `Asana` connector offers practical examples illustrating its use in various scenarios.
Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-asana/tree/main/examples/), covering the following use cases:

1. [Employee onboarding process automation](https://github.com/ballerina-platform/module-ballerinax-asana/tree/main/examples/employee-onboarding-process-automation) - Automate the onboarding process of new employees using Asana projects and tasks.
2. [Team workload balancer](https://github.com/ballerina-platform/module-ballerinax-asana/tree/main/examples/team-workload-balancer) - Evaluate and balance the workload of a given team using Asana tasks and assignments.
