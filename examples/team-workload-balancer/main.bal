// Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/log;
import ballerinax/asana;

configurable string authToken = ?;
configurable string workspaceId = ?;

// Initialize Asana client configuration
asana:ConnectionConfig asanaConfig = {
    auth: {
        token: authToken
    }
};
asana:Client asana = check new (asanaConfig);

public function main() returns error? {
    // Initialize a map to keep track of user workloads
    map<int> userWorkloads = {};

    // Get users in the workspace
    asana:Inline_response_200_49|error userResponse = asana->/users(workspace = workspaceId);
    if userResponse is error {
        return error("Error occurred while fetching users");
    }

    // Iterate through users to get their tasks
    foreach asana:UserCompact user in userResponse?.data ?: [] {
        string? userId = user?.gid;
        if userId is () {
            log:printWarn(string `User ID for name: ${user?.name ?: "unknown"} is not found`);
            continue;
        }

        asana:Inline_response_200_48|error tasksResponse = asana->/users/[userId]/user_task_list(workspace = workspaceId);
        if tasksResponse is error {
            log:printWarn(string `Error occurred while fetching tasks for user: ${user?.name ?: "unknown"}`);
            continue;
        }

        asana:UserTaskListResponse? taskList = tasksResponse?.data;

        if taskList is () {
            log:printWarn(string `User task list for user: ${user?.name ?: "unknown"} is not found`);
            continue;
        }

        // Increment the user's task count to represent their workload
        if userWorkloads.hasKey(userId) {
            userWorkloads[userId] = userWorkloads.get(userId) + 1;
        } else {
            userWorkloads[userId] = 1;
        }

        // Analyze the workload distribution
        int sum = userWorkloads.reduce(function(int total, int workload) returns int => total + workload, 0);
        int avgWorkload = sum / userWorkloads.length();
        foreach string usrId in userWorkloads.keys() {
            if userWorkloads.get(usrId) > avgWorkload {
                // Logic for users with high workload: suggest task reassignments or mark for review
            } else if userWorkloads[usrId] < avgWorkload {
                // Logic for users with low workload: identify as candidates for additional tasks
            }
        }

        // Based on this analysis, you could generate a report or a set of recommendations for rebalancing workloads across the team.
    }
}
