function getTableSize(t)
    local count = 0
    for _, __ in pairs(t) do
        count = count + 1
    end
    return count
end

describe("Test all", function()
    local GCP = require "resty.gcp"
    local gcp = GCP()

    it("Check GCP services exist", function()
        assert.is.table(gcp)
        assert.same(357, getTableSize(gcp))
    end)

    it("Check GCP access token", function()
        local AccessToken = require "resty.gcp.request.credentials.accesstoken"
        local gcpToken = AccessToken()
        assert.same("string", type(gcpToken.token))
        assert.same("number", type(gcpToken.expireTime))
        assert.same("boolean", type(gcpToken:needsRefresh()))
    end)

    -- Change param and gcp service
    it("Check GCP service functionality", function()
        local AccessToken = require "resty.gcp.request.credentials.accesstoken"
        local gcpToken = AccessToken()
        local param = { projectsId = "warren-personal", secretsId = "kong-secret-cmek"}
        assert.same("table", type(gcp.secretmanager_v1.versions.list(gcpToken, param).versions))
    end)

end)
