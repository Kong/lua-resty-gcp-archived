local http = require "resty.gcp.request.http.http"
local jwt = require "resty.jwt"
local cjson = require("cjson.safe").new()
local base64 = require "base64"

local function GetJwtToken(serviceAccount)
    local saDecode, err = cjson.decode(serviceAccount)
    if type(saDecode) ~= "table" then
        error("GCP Service Account expects JSON")
        return
    end
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
    local serviceAccount = '{"type": "service_account","project_id": "k8s-learn-313105","private_key_id": "5cd5a9af0513cd7a579438ea2bfa0185f0256016","private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDOMgqbEdIItpCK\nL4OTxg1R4/6IPJSUoFLfACD0leho1uJYASp4iYvE1T8HTAtA6/LccSYLhqnM7qL8\nKLCn1XijjnJrN2/5y4C59at0dYbWfiLMaCyDDAH+8cvcLdrcoD/cT4ELdUNBJdPA\nXwY+6ADLiKv+y1nVzumjcDjAGVGY2CVwtETgh3Y4N6NOePsrFN3NRzKH9Rogdyqr\nD0SNN9rbofEe0XiRS00hg3tlIoZ766UPN1m9y/ciARkYG8O/x3m1UQG0jSeYFqej\ncwr4ObKW3C44pRTZxlASQr8CgWGrSAEfWnNSElESUHe2jN+SqiNk5+qjfATiyNQH\n7zEZDs01AgMBAAECggEADuTyey0YXOTDIBg6iuwdfjLX6gNmQC4sjks2FjTV6uzK\nwMykwrw8ymUU/nPxxCjHDEFoHCEIFvON9mUCDb2Pz1C01yXUAtk+XTBvyCPNL6VA\n4j8MKBMv+biBn0/4pUM2GbXsfmVkDEqtNxImI1ki5ZDjy63ouVcO7W1nzAiIKmAh\nTcjnb3glEmAWsMmHNO6IEl30eE9Lb026epzMfowM1PYOpngxyE/K3OoroeYnfoay\njahaaXA3Zi5yEfVbB6GF5/YuaMGU5U5eBvTK3fZf+wGK5Foyu5gkKYmihK3I/XdV\nWvv0YgkO0Uv/rl6fIp5FFigyI+5sKO3+/Mc0JItCqQKBgQD8R4Ya3tyfvih+7bns\nDVCcXMA76cyWuCw2zIf5G9FPzEHHCwSP8gW1qJGXVcPkb10wYgPgu6DJSNQ0gTwm\nQZvoSqUyaw41Sq+H8BqBSe890djRP4boYddO3BK85tFlfZk7jcgAbtB58Fd5yfwL\n958IWd2md+2ObGZPCis5J+KNuwKBgQDRPIdTMWLHMvB6GLQ+dneFNBFa3K8SB6YH\npJjdKVc4DSobxcafRDq2eW4FlX3sGPvZWTmGifnQ0IgNjssDNlOAduNFxd+L8Nzw\neVTDEdVUI/95o7m/kaB/jXqF7j8XJjPdWGViBCqKimewP++YmEN4P6RC3YwUE9kr\nLohTdC3pzwKBgQCKxYU9Lq5JqL5546bL9B8Ng++yhU8m8TRRCH0bSHQA4yijpqnh\nzI3beVhs2J6i/6dRP/lGG6+8STWBlD1UBe8O/lCUxVLReb3IlwjdaaASb2ZG5Bz/\noyJenKwqAQXaQBaULc+AfXRsPwq/UZ41rwZp/5TvRzUDjRlSDRPtosT6lQKBgEb+\nr7gVsLuAWEJFcZskHUfQM/dNnAWVHMvJGKkqJtL4/Imx4MQXpYhWyXMRl0lt7L6B\n3Nf+pwooR5G6Gr47R7f2HwWEr2ZPUtgxgwYxXd4P3NaMLDGJGxlMiv84qKWVK9H1\n9Wh9m2WosqgF+akgOPxrM7QQckA5v908C7utVwrXAoGAXKptZtxWhN9Q9AiMwV1o\nNzrGfmZhmSNRW9eVNtBndy+HW49IsWNRoTEnpy+cm6zfUIJMeLBpX9zuYn9O5b2c\nHj3ZpPnncDFOQxYDTpYvCo8cj682+GwbuGUSWcYiunP5Wgw+41c2kTnkXAe/h5Tv\nbenQnLXs1A8j80D6YKx7D7g=\n-----END PRIVATE KEY-----\n","client_email": "consumesm@k8s-learn-313105.iam.gserviceaccount.com","client_id": "106415865045264088858","auth_uri": "https://accounts.google.com/o/oauth2/auth","token_uri": "https://oauth2.googleapis.com/token","auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs","client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/consumesm%40k8s-learn-313105.iam.gserviceaccount.com"}'
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
