# Ballerina Asana connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-asana/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-asana/actions/workflows/ci.yml)
[![Trivy](https://github.com/ballerina-platform/module-ballerinax-asana/actions/workflows/trivy-scan.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-asana/actions/workflows/trivy-scan.yml)
[![GraalVM Check](https://github.com/ballerina-platform/module-ballerinax-asana/actions/workflows/build-with-bal-test-graalvm.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-asana/actions/workflows/build-with-bal-test-graalvm.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-asana.svg)](https://github.com/ballerina-platform/module-ballerinax-asana/commits/master)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/asana.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%2Fasana)

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

### Step 1: Import the module

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


## Issues and projects

The **Issues** and **Projects** tabs are disabled for this repository as this is part of the Ballerina library. To report bugs, request new features, start new discussions, view project boards, etc., visit the Ballerina library [parent repository](https://github.com/ballerina-platform/ballerina-library).

This repository only contains the source code for the package.

## Build from the source

### Prerequisites

1. Download and install Java SE Development Kit (JDK) version 17. You can download it from either of the following sources:

    * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
    * [OpenJDK](https://adoptium.net/)

   > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Generate a Github access token with read package permissions, then set the following `env` variables:
    ```sh
   export packageUser=<Your GitHub Username>
   export packagePAT=<GitHub Personal Access Token>
    ```

3. Download and install [Docker](https://www.docker.com/get-started).

   > **Note**: Ensure that the Docker daemon is running before executing any tests.

### Build options

Execute the commands below to build from the source.

1. To build the package:

   ```bash
   ./gradlew clean build
   ```

2. To run the tests:

   ```bash
   ./gradlew clean test
   ```

3. To build the without the tests:

   ```bash
   ./gradlew clean build -x test
   ```

4. To run tests against different environment:

   ```bash
   ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
   ```

5. To debug package with a remote debugger:

   ```bash
   ./gradlew clean build -Pdebug=<port>
   ```

6. To debug with the Ballerina language:

   ```bash
   ./gradlew clean build -PbalJavaDebug=<port>
   ```

7. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToCentral=true
   ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

* For more information go to the [`asana` package](https://lib.ballerina.io/ballerinax/asana/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
