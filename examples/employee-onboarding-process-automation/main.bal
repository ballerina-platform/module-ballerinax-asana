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
import ballerinax/asana;

configurable string authToken = ?;
configurable string workspaceId = ?;
configurable string teamId = ?;
configurable string newEmployeeName = ?;

// Initialize Asana client configuration
asana:ConnectionConfig asanaConfig = {
    auth: {
        token: authToken
    }
};
asana:Client asana = check new (asanaConfig);

// Function to automate the creation of an employee onboarding project with tasks
public function main() returns error? {

    record {asana:ProjectCompact[] data?;} projects = check asana->/projects();

    asana:Tasks_body taskReq = {
        data: {
            name: "Email Marketing Campaign",
            notes: "Create a new email marketing campaign for the upcoming product launch.",
            workspace: "<workspaceId>",
            projects: ["<projectId>"]
        }
    };
    record {asana:TaskResponse data?;} taskCreated = check asana->/tasks.post(taskReq);
}
