_G._TEST = true
local GCP = require "resty.gcp"
local AccessToken = require "resty.gcp.request.credentials.accesstoken"
    

describe("Test", function()
    local gcp = GCP()
    local gcpToken = AccessToken()
    it("test", function()
        local param = { projectsId = "59185215115", secret = "pass-rotate"}
        -- assert.same("Hi", gcp.accesstoken)
        assert.same("Hi", gcp.secretmanager_v1.secrets.get(gcpToken, param))
    end)

end)
