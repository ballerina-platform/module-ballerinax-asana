# Examples

The `ballerinax/asana` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-asana/tree/main/examples), covering use cases like cache management, session management, and rate limiting.

1. [Employee onboarding process automation](https://github.com/ballerina-platform/module-ballerinax-asana/tree/main/examples/employee-onboarding-process-automation) - Automate the onboarding process of new employees using Asana projects and tasks.

2. [Team workload balancer](https://github.com/ballerina-platform/module-ballerinax-asana/tree/main/examples/team-workload-balancer) - Evaluate and balance the workload of a given team using Asana tasks and assignments.


## Prerequisites

1. Create an Asana personal access token (PAT) to authenticate the connector as described in the [Setup guide](https://central.ballerina.io/ballerinax/asana/latest#setup-guide).

2. For each example, create a `Config.toml` file the related configuration. Here's an example of how your `Config.toml` file should look:

    ```toml
    authToken="<auth_token>"
    workspaceId="<workspace_id>"
    ```

## Running an Example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```

## Building the Examples with the Local Module

**Warning**: Due to the absence of support for reading local repositories for single Ballerina files, the Bala of the module is manually written to the central repository as a workaround. Consequently, the bash script may modify your local Ballerina repositories.

Execute the following commands to build all the examples against the changes you have made to the module locally:

* To build all the examples:

    ```bash
    ./build.sh build
    ```

* To run all the examples:

    ```bash
    ./build.sh run
    ```
