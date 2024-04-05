import ballerina/log;
import ballerinax/asana;

configurable string workspaceId = ?;
configurable string bearerToken = ?;

// Initialize Asana client configuration
asana:ConnectionConfig asanaConfig = {
    auth: {
        token: bearerToken
    }
};

asana:Client asana = check new (asanaConfig);

public function main() returns error? {
    // Initialize a map to keep track of user workloads
    map<int> userWorkloads = {};

    // Get users in the workspace
    asana:Inline_response_200_49|error response = asana->/users(workspace = workspaceId);
    if response is asana:Inline_response_200_49 {
        // Iterate through users to get their tasks
        foreach asana:UserCompact user in response.data ?: [] {
            string? userId = user?.gid;
            if (userId is ()) {
                log:printWarn(string `User ID for name: ${user?.name ?: "unknown"} is not found`);
                continue;
            }

            asana:Inline_response_200_48 tasksResponse = check asana->/users/[userId]/user_task_list(workspace = workspaceId);
            asana:UserTaskListResponse? taskList = tasksResponse.data;
            if taskList is asana:UserTaskListResponse {
                // Increment the user's task count to represent their workload
                if (userWorkloads.hasKey(userId)) {
                    userWorkloads[userId] = userWorkloads.get(userId) + 1;
                } else {
                    userWorkloads[userId] = 1;
                }

                // Analyze the workload distribution
                int sum = userWorkloads.reduce(function(int total, int workload) returns int => total + workload, 0);
                int avgWorkload = sum / userWorkloads.length();
                foreach string usrId in userWorkloads.keys() {
                    if (userWorkloads.get(userId) > avgWorkload) {
                        // Logic for users with high workload: suggest task reassignments or mark for review
                    } else if (userWorkloads[userId] < avgWorkload) {
                        // Logic for users with low workload: identify as candidates for additional tasks
                    }
                }

                // Based on this analysis, you could generate a report or a set of recommendations for rebalancing workloads across the team.
            } else {
                log:printWarn(string `User task list for user: ${user?.name ?: "unknown"} is not found`);
            }
        }
    } else {
        return error("Error occurred while fetching users");
    }
}
