local decode = require("cjson").new().decode
return assert(decode([===[
{
    "version_module": true,
    "resources": {
      "projects": {
        "resources": {
          "locations": {
            "methods": {
              "list": {
                "scopes": [
                  "https://www.googleapis.com/auth/cloud-platform"
                ],
                "parameters": {
                  "filter": {
                    "location": "query",
                    "type": "string",
                    "description": "A filter to narrow down results to a preferred subset. The filtering language accepts strings like \"displayName=tokyo\", and is documented in more detail in [AIP-160](https://google.aip.dev/160)."
                  },
                  "pageToken": {
                    "description": "A page token received from the `next_page_token` field in the response. Send that page token to receive the subsequent page.",
                    "location": "query",
                    "type": "string"
                  },
                  "pageSize": {
                    "location": "query",
                    "description": "The maximum number of results to return. If not set, the service selects a default.",
                    "format": "int32",
                    "type": "integer"
                  },
                  "name": {
                    "type": "string",
                    "location": "path",
                    "required": true,
                    "description": "The resource that owns the locations collection, if applicable.",
                    "pattern": "^projects/[^/]+$"
                  }
                },
                "parameterOrder": [
                  "name"
                ],
                "id": "secretmanager.projects.locations.list",
                "response": {
                  "$ref": "ListLocationsResponse"
                },
                "httpMethod": "GET",
                "path": "v1beta1/{+name}/locations",
                "flatPath": "v1beta1/projects/{projectsId}/locations",
                "description": "Lists information about the supported locations for this service."
              },
              "get": {
                "scopes": [
                  "https://www.googleapis.com/auth/cloud-platform"
                ],
                "response": {
                  "$ref": "Location"
                },
                "path": "v1beta1/{+name}",
                "description": "Gets information about a location.",
                "flatPath": "v1beta1/projects/{projectsId}/locations/{locationsId}",
                "id": "secretmanager.projects.locations.get",
                "parameters": {
                  "name": {
                    "type": "string",
                    "pattern": "^projects/[^/]+/locations/[^/]+$",
                    "location": "path",
                    "required": true,
                    "description": "Resource name for the location."
                  }
                },
                "parameterOrder": [
                  "name"
                ],
                "httpMethod": "GET"
              }
            }
          },
          "secrets": {
            "methods": {
              "getIamPolicy": {
                "path": "v1beta1/{+resource}:getIamPolicy",
                "httpMethod": "GET",
                "scopes": [
                  "https://www.googleapis.com/auth/cloud-platform"
                ],
                "description": "Gets the access control policy for a secret. Returns empty policy if the secret exists and does not have a policy set.",
                "parameterOrder": [
                  "resource"
                ],
                "flatPath": "v1beta1/projects/{projectsId}/secrets/{secretsId}:getIamPolicy",
                "id": "secretmanager.projects.secrets.getIamPolicy",
                "response": {
                  "$ref": "Policy"
                },
                "parameters": {
                  "options.requestedPolicyVersion": {
                    "description": "Optional. The policy format version to be returned. Valid values are 0, 1, and 3. Requests specifying an invalid value will be rejected. Requests for policies with any conditional bindings must specify version 3. Policies without any conditional bindings may specify any valid value or leave the field unset. To learn which resources support conditions in their IAM policies, see the [IAM documentation](https://cloud.google.com/iam/help/conditions/resource-policies).",
                    "location": "query",
                    "type": "integer",
                    "format": "int32"
                  },
                  "resource": {
                    "type": "string",
                    "pattern": "^projects/[^/]+/secrets/[^/]+$",
                    "description": "REQUIRED: The resource for which the policy is being requested. See the operation documentation for the appropriate value for this field.",
                    "required": true,
                    "location": "path"
                  }
                }
              },
              "setIamPolicy": {
                "parameters": {
                  "resource": {
                    "required": true,
                    "location": "path",
                    "type": "string",
                    "pattern": "^projects/[^/]+/secrets/[^/]+$",
                    "description": "REQUIRED: The resource for which the policy is being specified. See the operation documentation for the appropriate value for this field."
                  }
                },
                "flatPath": "v1beta1/projects/{projectsId}/secrets/{secretsId}:setIamPolicy",
                "scopes": [
                  "https://www.googleapis.com/auth/cloud-platform"
                ],
                "id": "secretmanager.projects.secrets.setIamPolicy",
                "parameterOrder": [
                  "resource"
                ],
                "description": "Sets the access control policy on the specified secret. Replaces any existing policy. Permissions on SecretVersions are enforced according to the policy set on the associated Secret.",
                "request": {
                  "$ref": "SetIamPolicyRequest"
                },
                "response": {
                  "$ref": "Policy"
                },
                "path": "v1beta1/{+resource}:setIamPolicy",
                "httpMethod": "POST"
              },
              "patch": {
                "id": "secretmanager.projects.secrets.patch",
                "parameters": {
                  "name": {
                    "required": true,
                    "pattern": "^projects/[^/]+/secrets/[^/]+$",
                    "type": "string",
                    "location": "path",
                    "description": "Output only. The resource name of the Secret in the format `projects/*/secrets/*`."
                  },
                  "updateMask": {
                    "description": "Required. Specifies the fields to be updated.",
                    "type": "string",
                    "format": "google-fieldmask",
                    "location": "query"
                  }
                },
                "request": {
                  "$ref": "Secret"
                },
                "parameterOrder": [
                  "name"
                ],
                "httpMethod": "PATCH",
                "path": "v1beta1/{+name}",
                "response": {
                  "$ref": "Secret"
                },
                "scopes": [
                  "https://www.googleapis.com/auth/cloud-platform"
                ],
                "flatPath": "v1beta1/projects/{projectsId}/secrets/{secretsId}",
                "description": "Updates metadata of an existing Secret."
              },
              "testIamPermissions": {
                "request": {
                  "$ref": "TestIamPermissionsRequest"
                },
                "id": "secretmanager.projects.secrets.testIamPermissions",
                "httpMethod": "POST",
                "description": "Returns permissions that a caller has for the specified secret. If the secret does not exist, this call returns an empty set of permissions, not a NOT_FOUND error. Note: This operation is designed to be used for building permission-aware UIs and command-line tools, not for authorization checking. This operation may \"fail open\" without warning.",
                "flatPath": "v1beta1/projects/{projectsId}/secrets/{secretsId}:testIamPermissions",
                "path": "v1beta1/{+resource}:testIamPermissions",
                "parameters": {
                  "resource": {
                    "description": "REQUIRED: The resource for which the policy detail is being requested. See the operation documentation for the appropriate value for this field.",
                    "type": "string",
                    "pattern": "^projects/[^/]+/secrets/[^/]+$",
                    "location": "path",
                    "required": true
                  }
                },
                "response": {
                  "$ref": "TestIamPermissionsResponse"
                },
                "scopes": [
                  "https://www.googleapis.com/auth/cloud-platform"
                ],
                "parameterOrder": [
                  "resource"
                ]
              },
              "delete": {
                "path": "v1beta1/{+name}",
                "parameterOrder": [
                  "name"
                ],
                "parameters": {
                  "name": {
                    "location": "path",
                    "description": "Required. The resource name of the Secret to delete in the format `projects/*/secrets/*`.",
                    "required": true,
                    "pattern": "^projects/[^/]+/secrets/[^/]+$",
                    "type": "string"
                  }
                },
                "scopes": [
                  "https://www.googleapis.com/auth/cloud-platform"
                ],
                "flatPath": "v1beta1/projects/{projectsId}/secrets/{secretsId}",
                "httpMethod": "DELETE",
                "id": "secretmanager.projects.secrets.delete",
                "description": "Deletes a Secret.",
                "response": {
                  "$ref": "Empty"
                }
              },
              "get": {
                "parameterOrder": [
                  "name"
                ],
                "path": "v1beta1/{+name}",
                "scopes": [
                  "https://www.googleapis.com/auth/cloud-platform"
                ],
                "description": "Gets metadata for a given Secret.",
                "id": "secretmanager.projects.secrets.get",
                "httpMethod": "GET",
                "response": {
                  "$ref": "Secret"
                },
                "parameters": {
                  "name": {
                    "type": "string",
                    "description": "Required. The resource name of the Secret, in the format `projects/*/secrets/*`.",
                    "required": true,
                    "location": "path",
                    "pattern": "^projects/[^/]+/secrets/[^/]+$"
                  }
                },
                "flatPath": "v1beta1/projects/{projectsId}/secrets/{secretsId}"
              },
              "create": {
                "httpMethod": "POST",
                "response": {
                  "$ref": "Secret"
                },
                "scopes": [
                  "https://www.googleapis.com/auth/cloud-platform"
                ],
                "request": {
                  "$ref": "Secret"
                },
                "path": "v1beta1/{+parent}/secrets",
                "flatPath": "v1beta1/projects/{projectsId}/secrets",
                "id": "secretmanager.projects.secrets.create",
                "parameters": {
                  "secretId": {
                    "description": "Required. This must be unique within the project. A secret ID is a string with a maximum length of 255 characters and can contain uppercase and lowercase letters, numerals, and the hyphen (`-`) and underscore (`_`) characters.",
                    "type": "string",
                    "location": "query"
                  },
                  "parent": {
                    "location": "path",
                    "required": true,
                    "description": "Required. The resource name of the project to associate with the Secret, in the format `projects/*`.",
                    "type": "string",
                    "pattern": "^projects/[^/]+$"
                  }
                },
                "parameterOrder": [
                  "parent"
                ],
                "description": "Creates a new Secret containing no SecretVersions."
              },
              "addVersion": {
                "response": {
                  "$ref": "SecretVersion"
                },
                "parameterOrder": [
                  "parent"
                ],
                "description": "Creates a new SecretVersion containing secret data and attaches it to an existing Secret.",
                "path": "v1beta1/{+parent}:addVersion",
                "request": {
                  "$ref": "AddSecretVersionRequest"
                },
                "parameters": {
                  "parent": {
                    "type": "string",
                    "location": "path",
                    "description": "Required. The resource name of the Secret to associate with the SecretVersion in the format `projects/*/secrets/*`.",
                    "required": true,
                    "pattern": "^projects/[^/]+/secrets/[^/]+$"
                  }
                },
                "httpMethod": "POST",
                "flatPath": "v1beta1/projects/{projectsId}/secrets/{secretsId}:addVersion",
                "scopes": [
                  "https://www.googleapis.com/auth/cloud-platform"
                ],
                "id": "secretmanager.projects.secrets.addVersion"
              },
              "list": {
                "httpMethod": "GET",
                "response": {
                  "$ref": "ListSecretsResponse"
                },
                "parameters": {
                  "pageSize": {
                    "description": "Optional. The maximum number of results to be returned in a single page. If set to 0, the server decides the number of results to return. If the number is greater than 25000, it is capped at 25000.",
                    "format": "int32",
                    "location": "query",
                    "type": "integer"
                  },
                  "parent": {
                    "required": true,
                    "location": "path",
                    "pattern": "^projects/[^/]+$",
                    "type": "string",
                    "description": "Required. The resource name of the project associated with the Secrets, in the format `projects/*`."
                  },
                  "pageToken": {
                    "description": "Optional. Pagination token, returned earlier via ListSecretsResponse.next_page_token.",
                    "type": "string",
                    "location": "query"
                  }
                },
                "description": "Lists Secrets.",
                "scopes": [
                  "https://www.googleapis.com/auth/cloud-platform"
                ],
                "parameterOrder": [
                  "parent"
                ],
                "path": "v1beta1/{+parent}/secrets",
                "flatPath": "v1beta1/projects/{projectsId}/secrets",
                "id": "secretmanager.projects.secrets.list"
              }
            },
            "resources": {
              "versions": {
                "methods": {
                  "get": {
                    "response": {
                      "$ref": "SecretVersion"
                    },
                    "flatPath": "v1beta1/projects/{projectsId}/secrets/{secretsId}/versions/{versionsId}",
                    "parameters": {
                      "name": {
                        "required": true,
                        "pattern": "^projects/[^/]+/secrets/[^/]+/versions/[^/]+$",
                        "type": "string",
                        "location": "path",
                        "description": "Required. The resource name of the SecretVersion in the format `projects/*/secrets/*/versions/*`. `projects/*/secrets/*/versions/latest` is an alias to the `latest` SecretVersion."
                      }
                    },
                    "id": "secretmanager.projects.secrets.versions.get",
                    "parameterOrder": [
                      "name"
                    ],
                    "httpMethod": "GET",
                    "description": "Gets metadata for a SecretVersion. `projects/*/secrets/*/versions/latest` is an alias to the `latest` SecretVersion.",
                    "scopes": [
                      "https://www.googleapis.com/auth/cloud-platform"
                    ],
                    "path": "v1beta1/{+name}"
                  },
                  "access": {
                    "path": "v1beta1/{+name}:access",
                    "description": "Accesses a SecretVersion. This call returns the secret data. `projects/*/secrets/*/versions/latest` is an alias to the `latest` SecretVersion.",
                    "response": {
                      "$ref": "AccessSecretVersionResponse"
                    },
                    "flatPath": "v1beta1/projects/{projectsId}/secrets/{secretsId}/versions/{versionsId}:access",
                    "httpMethod": "GET",
                    "parameters": {
                      "name": {
                        "type": "string",
                        "location": "path",
                        "pattern": "^projects/[^/]+/secrets/[^/]+/versions/[^/]+$",
                        "required": true,
                        "description": "Required. The resource name of the SecretVersion in the format `projects/*/secrets/*/versions/*`."
                      }
                    },
                    "id": "secretmanager.projects.secrets.versions.access",
                    "parameterOrder": [
                      "name"
                    ],
                    "scopes": [
                      "https://www.googleapis.com/auth/cloud-platform"
                    ]
                  },
                  "destroy": {
                    "request": {
                      "$ref": "DestroySecretVersionRequest"
                    },
                    "id": "secretmanager.projects.secrets.versions.destroy",
                    "parameterOrder": [
                      "name"
                    ],
                    "path": "v1beta1/{+name}:destroy",
                    "httpMethod": "POST",
                    "description": "Destroys a SecretVersion. Sets the state of the SecretVersion to DESTROYED and irrevocably destroys the secret data.",
                    "parameters": {
                      "name": {
                        "description": "Required. The resource name of the SecretVersion to destroy in the format `projects/*/secrets/*/versions/*`.",
                        "required": true,
                        "type": "string",
                        "pattern": "^projects/[^/]+/secrets/[^/]+/versions/[^/]+$",
                        "location": "path"
                      }
                    },
                    "flatPath": "v1beta1/projects/{projectsId}/secrets/{secretsId}/versions/{versionsId}:destroy",
                    "scopes": [
                      "https://www.googleapis.com/auth/cloud-platform"
                    ],
                    "response": {
                      "$ref": "SecretVersion"
                    }
                  },
                  "enable": {
                    "flatPath": "v1beta1/projects/{projectsId}/secrets/{secretsId}/versions/{versionsId}:enable",
                    "id": "secretmanager.projects.secrets.versions.enable",
                    "path": "v1beta1/{+name}:enable",
                    "parameters": {
                      "name": {
                        "type": "string",
                        "required": true,
                        "pattern": "^projects/[^/]+/secrets/[^/]+/versions/[^/]+$",
                        "location": "path",
                        "description": "Required. The resource name of the SecretVersion to enable in the format `projects/*/secrets/*/versions/*`."
                      }
                    },
                    "httpMethod": "POST",
                    "description": "Enables a SecretVersion. Sets the state of the SecretVersion to ENABLED.",
                    "parameterOrder": [
                      "name"
                    ],
                    "scopes": [
                      "https://www.googleapis.com/auth/cloud-platform"
                    ],
                    "request": {
                      "$ref": "EnableSecretVersionRequest"
                    },
                    "response": {
                      "$ref": "SecretVersion"
                    }
                  },
                  "disable": {
                    "httpMethod": "POST",
                    "scopes": [
                      "https://www.googleapis.com/auth/cloud-platform"
                    ],
                    "path": "v1beta1/{+name}:disable",
                    "response": {
                      "$ref": "SecretVersion"
                    },
                    "parameters": {
                      "name": {
                        "description": "Required. The resource name of the SecretVersion to disable in the format `projects/*/secrets/*/versions/*`.",
                        "location": "path",
                        "pattern": "^projects/[^/]+/secrets/[^/]+/versions/[^/]+$",
                        "required": true,
                        "type": "string"
                      }
                    },
                    "id": "secretmanager.projects.secrets.versions.disable",
                    "description": "Disables a SecretVersion. Sets the state of the SecretVersion to DISABLED.",
                    "parameterOrder": [
                      "name"
                    ],
                    "request": {
                      "$ref": "DisableSecretVersionRequest"
                    },
                    "flatPath": "v1beta1/projects/{projectsId}/secrets/{secretsId}/versions/{versionsId}:disable"
                  },
                  "list": {
                    "response": {
                      "$ref": "ListSecretVersionsResponse"
                    },
                    "httpMethod": "GET",
                    "scopes": [
                      "https://www.googleapis.com/auth/cloud-platform"
                    ],
                    "parameters": {
                      "pageToken": {
                        "description": "Optional. Pagination token, returned earlier via ListSecretVersionsResponse.next_page_token][].",
                        "type": "string",
                        "location": "query"
                      },
                      "parent": {
                        "description": "Required. The resource name of the Secret associated with the SecretVersions to list, in the format `projects/*/secrets/*`.",
                        "type": "string",
                        "required": true,
                        "pattern": "^projects/[^/]+/secrets/[^/]+$",
                        "location": "path"
                      },
                      "pageSize": {
                        "format": "int32",
                        "type": "integer",
                        "location": "query",
                        "description": "Optional. The maximum number of results to be returned in a single page. If set to 0, the server decides the number of results to return. If the number is greater than 25000, it is capped at 25000."
                      }
                    },
                    "parameterOrder": [
                      "parent"
                    ],
                    "id": "secretmanager.projects.secrets.versions.list",
                    "description": "Lists SecretVersions. This call does not return secret data.",
                    "flatPath": "v1beta1/projects/{projectsId}/secrets/{secretsId}/versions",
                    "path": "v1beta1/{+parent}/versions"
                  }
                }
              }
            }
          }
        }
      }
    },
    "ownerDomain": "google.com",
    "rootUrl": "https://secretmanager.googleapis.com/",
    "mtlsRootUrl": "https://secretmanager.mtls.googleapis.com/",
    "canonicalName": "Secret Manager",
    "baseUrl": "https://secretmanager.googleapis.com/",
    "batchPath": "batch",
    "title": "Secret Manager API",
    "documentationLink": "https://cloud.google.com/secret-manager/",
    "description": "Stores sensitive data such as API keys, passwords, and certificates. Provides convenience while improving security. ",
    "version": "v1beta1",
    "name": "secretmanager",
    "revision": "20211001",
    "auth": {
      "oauth2": {
        "scopes": {
          "https://www.googleapis.com/auth/cloud-platform": {
            "description": "See, edit, configure, and delete your Google Cloud data and see the email address for your Google Account."
          }
        }
      }
    },
    "icons": {
      "x32": "http://www.google.com/images/icons/product/search-32.gif",
      "x16": "http://www.google.com/images/icons/product/search-16.gif"
    },
    "ownerName": "Google",
    "schemas": {
      "Policy": {
        "properties": {
          "bindings": {
            "description": "Associates a list of `members` to a `role`. Optionally, may specify a `condition` that determines how and when the `bindings` are applied. Each of the `bindings` must contain at least one member. The `bindings` in a `Policy` can refer to up to 1,500 members; up to 250 of these members can be Google groups. Each occurrence of a member counts towards these limits. For example, if the `bindings` grant 50 different roles to `user:alice@example.com`, and not to any other member, then you can add another 1,450 members to the `bindings` in the `Policy`.",
            "items": {
              "$ref": "Binding"
            },
            "type": "array"
          },
          "etag": {
            "description": "`etag` is used for optimistic concurrency control as a way to help prevent simultaneous updates of a policy from overwriting each other. It is strongly suggested that systems make use of the `etag` in the read-modify-write cycle to perform policy updates in order to avoid race conditions: An `etag` is returned in the response to `getIamPolicy`, and systems are expected to put that etag in the request to `setIamPolicy` to ensure that their change will be applied to the same version of the policy. **Important:** If you use IAM Conditions, you must include the `etag` field whenever you call `setIamPolicy`. If you omit this field, then IAM allows you to overwrite a version `3` policy with a version `1` policy, and all of the conditions in the version `3` policy are lost.",
            "format": "byte",
            "type": "string"
          },
          "version": {
            "format": "int32",
            "type": "integer",
            "description": "Specifies the format of the policy. Valid values are `0`, `1`, and `3`. Requests that specify an invalid value are rejected. Any operation that affects conditional role bindings must specify version `3`. This requirement applies to the following operations: * Getting a policy that includes a conditional role binding * Adding a conditional role binding to a policy * Changing a conditional role binding in a policy * Removing any role binding, with or without a condition, from a policy that includes conditions **Important:** If you use IAM Conditions, you must include the `etag` field whenever you call `setIamPolicy`. If you omit this field, then IAM allows you to overwrite a version `3` policy with a version `1` policy, and all of the conditions in the version `3` policy are lost. If a policy does not include any conditions, operations on that policy may specify any valid version or leave the field unset. To learn which resources support conditions in their IAM policies, see the [IAM documentation](https://cloud.google.com/iam/help/conditions/resource-policies)."
          },
          "auditConfigs": {
            "description": "Specifies cloud audit logging configuration for this policy.",
            "items": {
              "$ref": "AuditConfig"
            },
            "type": "array"
          }
        },
        "type": "object",
        "description": "An Identity and Access Management (IAM) policy, which specifies access controls for Google Cloud resources. A `Policy` is a collection of `bindings`. A `binding` binds one or more `members` to a single `role`. Members can be user accounts, service accounts, Google groups, and domains (such as G Suite). A `role` is a named list of permissions; each `role` can be an IAM predefined role or a user-created custom role. For some types of Google Cloud resources, a `binding` can also specify a `condition`, which is a logical expression that allows access to a resource only if the expression evaluates to `true`. A condition can add constraints based on attributes of the request, the resource, or both. To learn which resources support conditions in their IAM policies, see the [IAM documentation](https://cloud.google.com/iam/help/conditions/resource-policies). **JSON example:** { \"bindings\": [ { \"role\": \"roles/resourcemanager.organizationAdmin\", \"members\": [ \"user:mike@example.com\", \"group:admins@example.com\", \"domain:google.com\", \"serviceAccount:my-project-id@appspot.gserviceaccount.com\" ] }, { \"role\": \"roles/resourcemanager.organizationViewer\", \"members\": [ \"user:eve@example.com\" ], \"condition\": { \"title\": \"expirable access\", \"description\": \"Does not grant access after Sep 2020\", \"expression\": \"request.time \u003c timestamp('2020-10-01T00:00:00.000Z')\", } } ], \"etag\": \"BwWWja0YfJA=\", \"version\": 3 } **YAML example:** bindings: - members: - user:mike@example.com - group:admins@example.com - domain:google.com - serviceAccount:my-project-id@appspot.gserviceaccount.com role: roles/resourcemanager.organizationAdmin - members: - user:eve@example.com role: roles/resourcemanager.organizationViewer condition: title: expirable access description: Does not grant access after Sep 2020 expression: request.time \u003c timestamp('2020-10-01T00:00:00.000Z') etag: BwWWja0YfJA= version: 3 For a description of IAM and its features, see the [IAM documentation](https://cloud.google.com/iam/docs/).",
        "id": "Policy"
      },
      "DestroySecretVersionRequest": {
        "properties": {},
        "type": "object",
        "description": "Request message for SecretManagerService.DestroySecretVersion.",
        "id": "DestroySecretVersionRequest"
      },
      "ListLocationsResponse": {
        "properties": {
          "nextPageToken": {
            "description": "The standard List next-page token.",
            "type": "string"
          },
          "locations": {
            "type": "array",
            "items": {
              "$ref": "Location"
            },
            "description": "A list of locations that matches the specified filter in the request."
          }
        },
        "type": "object",
        "description": "The response message for Locations.ListLocations.",
        "id": "ListLocationsResponse"
      },
      "Replica": {
        "id": "Replica",
        "description": "Represents a Replica for this Secret.",
        "properties": {
          "location": {
            "type": "string",
            "description": "The canonical IDs of the location to replicate data. For example: `\"us-east1\"`."
          }
        },
        "type": "object"
      },
      "Replication": {
        "description": "A policy that defines the replication configuration of data.",
        "id": "Replication",
        "type": "object",
        "properties": {
          "userManaged": {
            "description": "The Secret will only be replicated into the locations specified.",
            "$ref": "UserManaged"
          },
          "automatic": {
            "$ref": "Automatic",
            "description": "The Secret will automatically be replicated without any restrictions."
          }
        }
      },
      "AccessSecretVersionResponse": {
        "description": "Response message for SecretManagerService.AccessSecretVersion.",
        "id": "AccessSecretVersionResponse",
        "properties": {
          "payload": {
            "$ref": "SecretPayload",
            "description": "Secret payload"
          },
          "name": {
            "type": "string",
            "description": "The resource name of the SecretVersion in the format `projects/*/secrets/*/versions/*`."
          }
        },
        "type": "object"
      },
      "ListSecretVersionsResponse": {
        "description": "Response message for SecretManagerService.ListSecretVersions.",
        "id": "ListSecretVersionsResponse",
        "properties": {
          "versions": {
            "description": "The list of SecretVersions sorted in reverse by create_time (newest first).",
            "type": "array",
            "items": {
              "$ref": "SecretVersion"
            }
          },
          "nextPageToken": {
            "description": "A token to retrieve the next page of results. Pass this value in ListSecretVersionsRequest.page_token to retrieve the next page.",
            "type": "string"
          },
          "totalSize": {
            "type": "integer",
            "description": "The total number of SecretVersions.",
            "format": "int32"
          }
        },
        "type": "object"
      },
      "SecretVersion": {
        "id": "SecretVersion",
        "properties": {
          "state": {
            "readOnly": true,
            "enum": [
              "STATE_UNSPECIFIED",
              "ENABLED",
              "DISABLED",
              "DESTROYED"
            ],
            "type": "string",
            "description": "Output only. The current state of the SecretVersion.",
            "enumDescriptions": [
              "Not specified. This value is unused and invalid.",
              "The SecretVersion may be accessed.",
              "The SecretVersion may not be accessed, but the secret data is still available and can be placed back into the ENABLED state.",
              "The SecretVersion is destroyed and the secret data is no longer stored. A version may not leave this state once entered."
            ]
          },
          "destroyTime": {
            "description": "Output only. The time this SecretVersion was destroyed. Only present if state is DESTROYED.",
            "readOnly": true,
            "type": "string",
            "format": "google-datetime"
          },
          "name": {
            "description": "Output only. The resource name of the SecretVersion in the format `projects/*/secrets/*/versions/*`. SecretVersion IDs in a Secret start at 1 and are incremented for each subsequent version of the secret.",
            "type": "string",
            "readOnly": true
          },
          "createTime": {
            "readOnly": true,
            "type": "string",
            "description": "Output only. The time at which the SecretVersion was created.",
            "format": "google-datetime"
          }
        },
        "description": "A secret version resource in the Secret Manager API.",
        "type": "object"
      },
      "AuditConfig": {
        "description": "Specifies the audit configuration for a service. The configuration determines which permission types are logged, and what identities, if any, are exempted from logging. An AuditConfig must have one or more AuditLogConfigs. If there are AuditConfigs for both `allServices` and a specific service, the union of the two AuditConfigs is used for that service: the log_types specified in each AuditConfig are enabled, and the exempted_members in each AuditLogConfig are exempted. Example Policy with multiple AuditConfigs: { \"audit_configs\": [ { \"service\": \"allServices\", \"audit_log_configs\": [ { \"log_type\": \"DATA_READ\", \"exempted_members\": [ \"user:jose@example.com\" ] }, { \"log_type\": \"DATA_WRITE\" }, { \"log_type\": \"ADMIN_READ\" } ] }, { \"service\": \"sampleservice.googleapis.com\", \"audit_log_configs\": [ { \"log_type\": \"DATA_READ\" }, { \"log_type\": \"DATA_WRITE\", \"exempted_members\": [ \"user:aliya@example.com\" ] } ] } ] } For sampleservice, this policy enables DATA_READ, DATA_WRITE and ADMIN_READ logging. It also exempts jose@example.com from DATA_READ logging, and aliya@example.com from DATA_WRITE logging.",
        "id": "AuditConfig",
        "type": "object",
        "properties": {
          "service": {
            "description": "Specifies a service that will be enabled for audit logging. For example, `storage.googleapis.com`, `cloudsql.googleapis.com`. `allServices` is a special value that covers all services.",
            "type": "string"
          },
          "auditLogConfigs": {
            "type": "array",
            "description": "The configuration for logging of each type of permission.",
            "items": {
              "$ref": "AuditLogConfig"
            }
          }
        }
      },
      "AuditLogConfig": {
        "type": "object",
        "description": "Provides the configuration for logging a type of permissions. Example: { \"audit_log_configs\": [ { \"log_type\": \"DATA_READ\", \"exempted_members\": [ \"user:jose@example.com\" ] }, { \"log_type\": \"DATA_WRITE\" } ] } This enables 'DATA_READ' and 'DATA_WRITE' logging, while exempting jose@example.com from DATA_READ logging.",
        "properties": {
          "logType": {
            "type": "string",
            "description": "The log type that this config enables.",
            "enum": [
              "LOG_TYPE_UNSPECIFIED",
              "ADMIN_READ",
              "DATA_WRITE",
              "DATA_READ"
            ],
            "enumDescriptions": [
              "Default case. Should never be this.",
              "Admin reads. Example: CloudIAM getIamPolicy",
              "Data writes. Example: CloudSQL Users create",
              "Data reads. Example: CloudSQL Users list"
            ]
          },
          "exemptedMembers": {
            "type": "array",
            "items": {
              "type": "string"
            },
            "description": "Specifies the identities that do not cause logging for this type of permission. Follows the same format of Binding.members."
          }
        },
        "id": "AuditLogConfig"
      },
      "ListSecretsResponse": {
        "description": "Response message for SecretManagerService.ListSecrets.",
        "properties": {
          "nextPageToken": {
            "description": "A token to retrieve the next page of results. Pass this value in ListSecretsRequest.page_token to retrieve the next page.",
            "type": "string"
          },
          "secrets": {
            "description": "The list of Secrets sorted in reverse by create_time (newest first).",
            "items": {
              "$ref": "Secret"
            },
            "type": "array"
          },
          "totalSize": {
            "description": "The total number of Secrets.",
            "type": "integer",
            "format": "int32"
          }
        },
        "type": "object",
        "id": "ListSecretsResponse"
      },
      "DisableSecretVersionRequest": {
        "id": "DisableSecretVersionRequest",
        "type": "object",
        "properties": {},
        "description": "Request message for SecretManagerService.DisableSecretVersion."
      },
      "Expr": {
        "type": "object",
        "properties": {
          "location": {
            "description": "Optional. String indicating the location of the expression for error reporting, e.g. a file name and a position in the file.",
            "type": "string"
          },
          "expression": {
            "type": "string",
            "description": "Textual representation of an expression in Common Expression Language syntax."
          },
          "description": {
            "description": "Optional. Description of the expression. This is a longer text which describes the expression, e.g. when hovered over it in a UI.",
            "type": "string"
          },
          "title": {
            "description": "Optional. Title for the expression, i.e. a short string describing its purpose. This can be used e.g. in UIs which allow to enter the expression.",
            "type": "string"
          }
        },
        "description": "Represents a textual expression in the Common Expression Language (CEL) syntax. CEL is a C-like expression language. The syntax and semantics of CEL are documented at https://github.com/google/cel-spec. Example (Comparison): title: \"Summary size limit\" description: \"Determines if a summary is less than 100 chars\" expression: \"document.summary.size() \u003c 100\" Example (Equality): title: \"Requestor is owner\" description: \"Determines if requestor is the document owner\" expression: \"document.owner == request.auth.claims.email\" Example (Logic): title: \"Public documents\" description: \"Determine whether the document should be publicly visible\" expression: \"document.type != 'private' && document.type != 'internal'\" Example (Data Manipulation): title: \"Notification string\" description: \"Create a notification string with a timestamp.\" expression: \"'New message received at ' + string(document.create_time)\" The exact variables and functions that may be referenced within an expression are determined by the service that evaluates it. See the service documentation for additional information.",
        "id": "Expr"
      },
      "TestIamPermissionsRequest": {
        "id": "TestIamPermissionsRequest",
        "properties": {
          "permissions": {
            "items": {
              "type": "string"
            },
            "description": "The set of permissions to check for the `resource`. Permissions with wildcards (such as '*' or 'storage.*') are not allowed. For more information see [IAM Overview](https://cloud.google.com/iam/docs/overview#permissions).",
            "type": "array"
          }
        },
        "description": "Request message for `TestIamPermissions` method.",
        "type": "object"
      },
      "UserManaged": {
        "description": "A replication policy that replicates the Secret payload into the locations specified in Secret.replication.user_managed.replicas",
        "id": "UserManaged",
        "properties": {
          "replicas": {
            "type": "array",
            "items": {
              "$ref": "Replica"
            },
            "description": "Required. The list of Replicas for this Secret. Cannot be empty."
          }
        },
        "type": "object"
      },
      "Secret": {
        "id": "Secret",
        "type": "object",
        "description": "A Secret is a logical secret whose value and versions can be accessed. A Secret is made up of zero or more SecretVersions that represent the secret data.",
        "properties": {
          "replication": {
            "description": "Required. Immutable. The replication policy of the secret data attached to the Secret. The replication policy cannot be changed after the Secret has been created.",
            "$ref": "Replication"
          },
          "name": {
            "type": "string",
            "readOnly": true,
            "description": "Output only. The resource name of the Secret in the format `projects/*/secrets/*`."
          },
          "createTime": {
            "type": "string",
            "readOnly": true,
            "format": "google-datetime",
            "description": "Output only. The time at which the Secret was created."
          },
          "labels": {
            "description": "The labels assigned to this Secret. Label keys must be between 1 and 63 characters long, have a UTF-8 encoding of maximum 128 bytes, and must conform to the following PCRE regular expression: `\\p{Ll}\\p{Lo}{0,62}` Label values must be between 0 and 63 characters long, have a UTF-8 encoding of maximum 128 bytes, and must conform to the following PCRE regular expression: `[\\p{Ll}\\p{Lo}\\p{N}_-]{0,63}` No more than 64 labels can be assigned to a given resource.",
            "additionalProperties": {
              "type": "string"
            },
            "type": "object"
          }
        }
      },
      "AddSecretVersionRequest": {
        "type": "object",
        "properties": {
          "payload": {
            "description": "Required. The secret payload of the SecretVersion.",
            "$ref": "SecretPayload"
          }
        },
        "id": "AddSecretVersionRequest",
        "description": "Request message for SecretManagerService.AddSecretVersion."
      },
      "Location": {
        "properties": {
          "metadata": {
            "additionalProperties": {
              "type": "any",
              "description": "Properties of the object. Contains field @type with type URL."
            },
            "description": "Service-specific metadata. For example the available capacity at the given location.",
            "type": "object"
          },
          "locationId": {
            "type": "string",
            "description": "The canonical id for this location. For example: `\"us-east1\"`."
          },
          "displayName": {
            "description": "The friendly name for this location, typically a nearby city name. For example, \"Tokyo\".",
            "type": "string"
          },
          "labels": {
            "additionalProperties": {
              "type": "string"
            },
            "type": "object",
            "description": "Cross-service attributes for the location. For example {\"cloud.googleapis.com/region\": \"us-east1\"}"
          },
          "name": {
            "type": "string",
            "description": "Resource name for the location, which may vary between implementations. For example: `\"projects/example-project/locations/us-east1\"`"
          }
        },
        "type": "object",
        "id": "Location",
        "description": "A resource that represents Google Cloud Platform location."
      },
      "TestIamPermissionsResponse": {
        "description": "Response message for `TestIamPermissions` method.",
        "id": "TestIamPermissionsResponse",
        "type": "object",
        "properties": {
          "permissions": {
            "type": "array",
            "items": {
              "type": "string"
            },
            "description": "A subset of `TestPermissionsRequest.permissions` that the caller is allowed."
          }
        }
      },
      "SecretPayload": {
        "id": "SecretPayload",
        "properties": {
          "data": {
            "format": "byte",
            "description": "The secret data. Must be no larger than 64KiB.",
            "type": "string"
          }
        },
        "type": "object",
        "description": "A secret payload resource in the Secret Manager API. This contains the sensitive secret data that is associated with a SecretVersion."
      },
      "Binding": {
        "id": "Binding",
        "description": "Associates `members` with a `role`.",
        "type": "object",
        "properties": {
          "condition": {
            "description": "The condition that is associated with this binding. If the condition evaluates to `true`, then this binding applies to the current request. If the condition evaluates to `false`, then this binding does not apply to the current request. However, a different role binding might grant the same role to one or more of the members in this binding. To learn which resources support conditions in their IAM policies, see the [IAM documentation](https://cloud.google.com/iam/help/conditions/resource-policies).",
            "$ref": "Expr"
          },
          "role": {
            "description": "Role that is assigned to `members`. For example, `roles/viewer`, `roles/editor`, or `roles/owner`.",
            "type": "string"
          },
          "members": {
            "description": "Specifies the identities requesting access for a Cloud Platform resource. `members` can have the following values: * `allUsers`: A special identifier that represents anyone who is on the internet; with or without a Google account. * `allAuthenticatedUsers`: A special identifier that represents anyone who is authenticated with a Google account or a service account. * `user:{emailid}`: An email address that represents a specific Google account. For example, `alice@example.com` . * `serviceAccount:{emailid}`: An email address that represents a service account. For example, `my-other-app@appspot.gserviceaccount.com`. * `group:{emailid}`: An email address that represents a Google group. For example, `admins@example.com`. * `deleted:user:{emailid}?uid={uniqueid}`: An email address (plus unique identifier) representing a user that has been recently deleted. For example, `alice@example.com?uid=123456789012345678901`. If the user is recovered, this value reverts to `user:{emailid}` and the recovered user retains the role in the binding. * `deleted:serviceAccount:{emailid}?uid={uniqueid}`: An email address (plus unique identifier) representing a service account that has been recently deleted. For example, `my-other-app@appspot.gserviceaccount.com?uid=123456789012345678901`. If the service account is undeleted, this value reverts to `serviceAccount:{emailid}` and the undeleted service account retains the role in the binding. * `deleted:group:{emailid}?uid={uniqueid}`: An email address (plus unique identifier) representing a Google group that has been recently deleted. For example, `admins@example.com?uid=123456789012345678901`. If the group is recovered, this value reverts to `group:{emailid}` and the recovered group retains the role in the binding. * `domain:{domain}`: The G Suite domain (primary) that represents all the users of that domain. For example, `google.com` or `example.com`. ",
            "type": "array",
            "items": {
              "type": "string"
            }
          }
        }
      },
      "SetIamPolicyRequest": {
        "id": "SetIamPolicyRequest",
        "description": "Request message for `SetIamPolicy` method.",
        "type": "object",
        "properties": {
          "policy": {
            "description": "REQUIRED: The complete policy to be applied to the `resource`. The size of the policy is limited to a few 10s of KB. An empty policy is a valid policy but certain Cloud Platform services (such as Projects) might reject them.",
            "$ref": "Policy"
          },
          "updateMask": {
            "format": "google-fieldmask",
            "type": "string",
            "description": "OPTIONAL: A FieldMask specifying which fields of the policy to modify. Only the fields in the mask will be modified. If no mask is provided, the following default mask is used: `paths: \"bindings, etag\"`"
          }
        }
      },
      "Empty": {
        "properties": {},
        "description": "A generic empty message that you can re-use to avoid defining duplicated empty messages in your APIs. A typical example is to use it as the request or the response type of an API method. For instance: service Foo { rpc Bar(google.protobuf.Empty) returns (google.protobuf.Empty); } The JSON representation for `Empty` is empty JSON object `{}`.",
        "id": "Empty",
        "type": "object"
      },
      "Automatic": {
        "properties": {},
        "type": "object",
        "id": "Automatic",
        "description": "A replication policy that replicates the Secret payload without any restrictions."
      },
      "EnableSecretVersionRequest": {
        "description": "Request message for SecretManagerService.EnableSecretVersion.",
        "type": "object",
        "properties": {},
        "id": "EnableSecretVersionRequest"
      }
    },
    "discoveryVersion": "v1",
    "basePath": "",
    "id": "secretmanager:v1beta1",
    "kind": "discovery#restDescription",
    "fullyEncodeReservedExpansion": true,
    "protocol": "rest",
    "parameters": {
      "quotaUser": {
        "location": "query",
        "description": "Available to use for quota purposes for server-side applications. Can be any arbitrary string assigned to a user, but should not exceed 40 characters.",
        "type": "string"
      },
      "key": {
        "type": "string",
        "location": "query",
        "description": "API key. Your API key identifies your project and provides you with API access, quota, and reports. Required unless you provide an OAuth 2.0 token."
      },
      "access_token": {
        "type": "string",
        "location": "query",
        "description": "OAuth access token."
      },
      "callback": {
        "description": "JSONP",
        "type": "string",
        "location": "query"
      },
      "fields": {
        "description": "Selector specifying which fields to include in a partial response.",
        "type": "string",
        "location": "query"
      },
      "oauth_token": {
        "description": "OAuth 2.0 token for the current user.",
        "type": "string",
        "location": "query"
      },
      "alt": {
        "enum": [
          "json",
          "media",
          "proto"
        ],
        "default": "json",
        "description": "Data format for response.",
        "type": "string",
        "location": "query",
        "enumDescriptions": [
          "Responses with Content-Type of application/json",
          "Media download with context-dependent Content-Type",
          "Responses with Content-Type of application/x-protobuf"
        ]
      },
      "upload_protocol": {
        "type": "string",
        "description": "Upload protocol for media (e.g. \"raw\", \"multipart\").",
        "location": "query"
      },
      "$.xgafv": {
        "type": "string",
        "enumDescriptions": [
          "v1 error format",
          "v2 error format"
        ],
        "location": "query",
        "enum": [
          "1",
          "2"
        ],
        "description": "V1 error format."
      },
      "uploadType": {
        "location": "query",
        "type": "string",
        "description": "Legacy upload protocol for media (e.g. \"media\", \"multipart\")."
      },
      "prettyPrint": {
        "default": "true",
        "type": "boolean",
        "description": "Returns response with indentations and line breaks.",
        "location": "query"
      }
    },
    "servicePath": ""
  }
]===]))