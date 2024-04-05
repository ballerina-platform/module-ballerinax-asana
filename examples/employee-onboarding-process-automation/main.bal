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

    // Step 1: Create a new onboarding project
    asana:Projects_body projectBody = {
        data: {
            name: "Onboarding - " + newEmployeeName,
            workspace: workspaceId,
            team: teamId
        }
    };

    asana:Inline_response_201_5|error projectResponse = asana->/projects.post(projectBody);
    if projectResponse is error {
        return error("error creating project: " + projectResponse.message());
    }

    string? projectId = projectResponse?.data?.gid;
    if projectId is () {
        return error("project ID not found in response");
    }

    // Step 2: Add sections to the new project
    string[] sections = ["Documentation", "Training", "Setup"];
    foreach var sectionName in sections {
        asana:Project_gid_sections_body sectionBody = {
            data: {
                name: sectionName
            }
        };

        asana:Inline_response_200_30|error sectionCreationResult = asana->/projects/[projectId]/sections.post(sectionBody);
        if sectionCreationResult is error {
            return error("error creating section: " + sectionCreationResult.message());
        }
    }

    // Step 3: Create tasks within each section (simplified for brevity)
    // In a complete implementation, you'd likely query the sections of the project first to get their IDs.
    string[] tasks = ["Complete HR paperwork", "Setup work email", "Attend orientation session"];
    foreach string taskName in tasks {
        asana:Tasks_body newTaskPayload = {
            data: {
                name: taskName,
                projects: [projectId],
                assignee_section: "<section_id>"
            }
        };

        asana:Inline_response_201_7|error taskCreationResponse = asana->/tasks.post(newTaskPayload);
        if taskCreationResponse is error {
            return error("error creating task: " + taskCreationResponse.message());
        }
    }
}
