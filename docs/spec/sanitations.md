_Author_: @NipunaRanasinghe \
_Created_: 2024/03/26 \
_Updated_: 2024/03/26 \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from Asana. The OpenAPI specification is obtained from the [Asana OpenAPI repository](https://github.com/Asana/openapi/).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.

1. Change the type of `resource_subtype` property of the `AttachmentResponse` object from `string` to an enum of  `default_task`. `milestone`, `section`, `approval`.
    * This change is done to address the issue where the `resource_subtype` property is incorrectly overridden by the `resource_subtype` property of the `TaskCompact` object.

2. Fix incorrect response types of the `getUsers` operation.
    * The `getUsers` operation is expected to return a list of `UserCompact` objects, but the OpenAPI specification incorrectly defines the response type as HTTP Bad Request.

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/openapi.yaml --mode client  --license docs/license.txt -o ballerina/
```
Note: The license year is hardcoded to 2024, change if necessary.
