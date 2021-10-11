local cjson = require("cjson")

local lookup_helper = function(self, key)  -- signature to match __index meta-method
  if type(key) == "string" then
    local lckey = key:lower()
    for k,v in pairs(self) do
      if type(k) == "string" and k:lower() == lckey then
        error(("key '%s' not found, did you mean '%s'?"):format(key, k), 2)
      end
    end
  end
  error(("key '%s' not found"):format(tostring(key)), 2)
end

FindApis = function(apiClass, methods, curr)

    if type(apiClass) == "table" then
      for k, v in pairs(apiClass) do
        if k == "baseUrl" then
          methods[k] = v
        end
        if k == "methods" then
          methods[curr] = v
        end
        if type(v) == "table" then
          FindApis(v, methods, k)
        end
      end
    end

  return methods
end 

BuildMethods = function(methods)
  local baseUrl = methods.baseUrl
  local services = {}

  for k, v in pairs(methods) do
    if type(v) == "table" then
      services[k] = {}
      for serviceName, apiDetail in pairs(v) do
        services[k][serviceName] = function(opts)
          local httpMethod = apiDetail.httpMethod
          local version = apiDetail.path
          local flatPath = apiDetail.flatPath
          print(httpMethod)
          print(version)
          print(flatPath)
          return "hi"
        end
      end
    end
  end
  return setmetatable(services, {__index = lookup_helper})
end

local GenerateServices = function(apiList)
  local servicesInstance = {}
  
  for _, service in pairs(apiList) do
    local rawAPI = require("resty.gcp.api." .. service)
    local methods = FindApis(rawAPI, {})
    servicesInstance[service] = BuildMethods(methods)
    print(servicesInstance[service].secrets.testIamPermissions())
  end

  return setmetatable(servicesInstance, {__index = lookup_helper})
end

local GCP = {}
GCP.__index = lookup_helper

function GCP:new()

    local AccessToken = require "resty.gcp.request.credentials.accesstoken"
    local accessToken = AccessToken()

    local apis = { "secretmanager" }
    local services = GenerateServices(apis)

    -- print(cjson.encode(services.secretmanager))
    
    local gcp_instance = setmetatable({
        access_token = accessToken,
        services
      }, GCP)
    return gcp_instance;
end

return setmetatable(GCP, {
    __call = function(self, ...)
        return self:new(...)
    end,
})
  
