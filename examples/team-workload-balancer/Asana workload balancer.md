# Asana team workload balancer

This use case demonstrates how to balance the workload of a team using Asana. The team workload balancer analyzes tasks and assignments across all projects in Asana to help managers redistribute workloads more evenly. 
It identifies team members with high or low workloads and suggests adjustments to ensure balanced distribution of tasks.

## Prerequisites

### 1. Setup Asana account

Refer to the [Setup guide](https://central.ballerina.io/ballerinax/asana/latest#setup-guide) to set up your Asana account, if you do not have one.

### 2. Configuration

Update your Asana account related configurations in the `Config.toml` file in the example root directory:

```toml
bearerToken = "<bearer_token>"
workspaceId = "<workspace_gid>"
```

## Run the example

Execute the following command to run the example:

```ballerina
bal run
```
