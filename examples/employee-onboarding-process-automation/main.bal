import ballerinax/asana;

configurable string bearerToken = ?;
configurable string workspaceId = ?;
configurable string teamId = ?;
configurable string newEmployeeName = ?;

// Initialize Asana client configuration
asana:ConnectionConfig asanaConfig = {
    auth: {
        token: bearerToken
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
        if (sectionCreationResult is error) {
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

        var taskCreationResponse = asana->/tasks.post(newTaskPayload);
        if (taskCreationResponse is error) {
            return taskCreationResponse;
        }
    }
}
