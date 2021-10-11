

describe("Test", function()
    local GCP = require "resty.gcp"
    local gcp = GCP()
    it("test", function()
        assert.same("Hi", gcp)
    end)

end)
