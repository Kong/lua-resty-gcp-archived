

describe("Test", function()
    local GCP = require "resty.gcp"
    local AccessToken = require "resty.gcp.request.credentials.accesstoken"
    
    local gcp = GCP()
    local gcpToken = AccessToken()
    it("test", function()
        local param = { projectsId = "warren-personal", secret = "kong-secret-cmek"}
        -- assert.same("Hi", gcp.accesstoken)
        assert.same("Hi", gcp.secretmanager_v1.secrets.list(gcpToken, param))
    end)

end)
