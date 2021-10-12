local http = require "resty.gcp.request.http.http"
local jwt = require "resty.jwt"
local cjson = require("cjson")
local base64 = require "base64"

local function GetJwtToken(serviceAccount)
    local saDecode = cjson.decode(serviceAccount)
    local timeNow = os.time(os.date("!*t"))
    if (not (saDecode.client_email and saDecode.private_key and saDecode.private_key_id)) then
        error("Invalid GCP Service Account JSON")
        return
    end
    local payload = {
        iss = saDecode.client_email,
        sub = saDecode.client_email,
        aud = "https://www.googleapis.com/oauth2/v4/token",
        iat = timeNow,
        exp = timeNow + 3600,
        scope = "https://www.googleapis.com/auth/cloud-platform"
    }
    local payloadJson = cjson.encode(payload)
    local jwt_token =
        jwt:sign(
        saDecode.private_key,
        {
            header = {kid = saDecode.private_key_id, typ = "JWT", alg = "RS256"},
            payload = payloadJson
        }
    )
    return jwt_token
end

local function GetAccessTokenByJwt(jwtToken)
    local client = http.new()
    local auth_url = "https://www.googleapis.com/oauth2/v4/token"
    local params = {
        grant_type = "urn:ietf:params:oauth:grant-type:jwt-bearer",
        assertion = jwtToken
    }
    local res, err =
        client:request_uri(
        auth_url,
        {
            method = "POST",
            body = cjson.encode(params),
            ssl_verify = false
        }
    )
    if not res then
        error(err)
        return
    end
    client:close()
    local accessToken = cjson.decode(res.body)
    return accessToken
end

local function GetAccessTokenBySA(serviceAccount)
    if not serviceAccount then
        return
    end
    print("Using Envrionment Service Account to get Access Token")
    local jwtToken = GetJwtToken(serviceAccount)
    return GetAccessTokenByJwt(jwtToken), "SA"
end

local function GetAccessTokenHardcoded()
    print("Using Hardcoded Service Account to get Access Token")
    local serviceAccount = "Hardcode Service Account Here"
    local jwtToken = GetJwtToken(serviceAccount)
    local accessToken = GetAccessTokenByJwt(jwtToken)
    return accessToken, "Hardcoded"
end

local function GetAccessTokenByWI()
    local client = http.new()
    local auth_url = "http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/token"
    res, err =
        client:request_uri(
        auth_url,
        {
            headers = {
                ["Metadata-Flavor"] = "Google"
            },
            ssl_verify = false
        }
    )
    if not res then
        return
    end
    client:close()
    print("Using Workload Identity to get Access Token")
    local accessToken = cjson.decode(res.body)
    return accessToken, "WI"
end

local AccessToken = {}
AccessToken.__index = AccessToken
function AccessToken:new()
    local self = {}
    setmetatable(self, AccessToken)
    local gcpServiceAccount = os.getenv("GCP_SERVICE_ACCOUNT")
    local accessToken, authMetod =
        GetAccessTokenBySA(gcpServiceAccount) or GetAccessTokenByWI() or GetAccessTokenHardcoded()
    if (accessToken) then
        self.token = accessToken.access_token
        self.expireTime = ngx.now() + accessToken.expires_in
        self.authMethod = authMethod
    else
        error("All Auth Failed")
    end
    return self
end

function AccessToken:needsRefresh()
    return self.expireTime < ngx.now()
end

function AccessToken:refresh()
    local accessToken
    if (self.authMethod == "SA") then
        local gcpServiceAccount = os.getenv("GCP_SERVICE_ACCOUNT")
        accessToken = GetAccessTokenBySA(gcpServiceAccount)
    elseif (self.authMethod == "WI") then
        accessToken = GetAccessTokenByWI()
    else
        accessToken = GetAccessTokenHardcoded()
    end
    if (accessToken) then
        self.token = accessToken.access_token
        self.expireTime = ngx.now() + accessToken.expires_in
        return true
    end
    return false
end

return setmetatable(
    AccessToken,
    {
        __call = function(self, ...)
            return self:new(...)
        end
    }
)