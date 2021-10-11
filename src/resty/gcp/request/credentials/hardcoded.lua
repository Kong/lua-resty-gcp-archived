
local Super = require "resty.gcp.request.credentials.accesstoken"
local Hardcoded = setmetatable({}, Super)
Hardcoded.__index = Hardcoded

local function GetJwtToken(serviceAccount)

    local saDecode = cjson.decode(serviceAccount)
  
    local timeNow = os.time(os.date("!*t"))
  
    if (not (saDecode.client_email and saDecode.private_key and saDecode.private_key_id)) then
      -- error("Invalid GCP Service Account JSON")
      return
    end
  
    local payload = {
      iss = saDecode.client_email,
      sub = saDecode.client_email,
      aud = 'https://www.googleapis.com/oauth2/v4/token',
      iat = timeNow,
      exp = timeNow + 3600,
      scope = 'https://www.googleapis.com/auth/cloud-platform'
    }
  
    local payloadJson = cjson.encode(payload)
  
    local jwt_token = jwt:sign(
      saDecode.private_key,
      {
          header={kid=saDecode.private_key_id, typ="JWT", alg="RS256"},
          payload=payloadJson
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
  
    local res, err = client:request_uri(auth_url, {
      method = "POST",
      body = cjson.encode(params),
      ssl_verify = false
    })
    if not res then
      error(err)
      return
    end
  
    client:close()
  
    local accessToken = cjson.decode(res.body)
  
    return accessToken
  
end

function Hardcoded:new()
  local self = Super:new()
  setmetatable(self, Hardcoded)
  local gcpServiceAccount = [[{"type":"service_account","project_id":"warren-personal","private_key_id":"58a5c04d057fc0d33cabc940a0d6a52871adf8f7","private_key":"-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCq8F6Mr3M/nEQF\ngQqi9n1nMyMLJtTP/YILTGH7tYXBbw7ya8kjGPo0FLhq5eClGmF26ck6REkqTfE+\nNil6+N3k6tmYYcogqPSi3tUxPXUb/oxbAr2GPRGkQ5Ek3RsjSma1fB8nGmByqjIb\nBMWOkKEDUX/OgIKu51RYwk8arFA9w90P08UTLaBSSmUy+j6Id15Nb0FNuo1cmRz7\njQePrptl604F7s43wAinlr1DO1x5eRUJL1OdDdbPGh2D5EqLeqDXxrk8PXMd/pFj\nbjxdEz1ipgmJLu8Em2cdR3P/STfbOZMYw28Du9Dw79DBIOjMwSFPNdQKMEtR2lIn\ntv+iHPzdAgMBAAECggEADxHArBNdjBqJDpkpKGOle38RFE8YjLtzBu71ZlzCzWIu\nhaWF5k+x4vx+o4Hfc36nX/XNNRNHBfE4Fr1sm7gry53+j8XzLTzn0CHn1n7t/4lJ\ns05DCf4BO6NvPLo3Rb2t30rxbh+PqBwj7ajWh7JtV18MbtZ6btPa5jY/BgFx03f3\nMpuy25Hqo8GRvy8ip8bi2aP91W2m7x9sqORJJ6inrLjkIBbBYPeLRofX1ghNHp7S\nRKR2mnIXkAL6CSvwbV1NoioPGls//viFKjfTZaILtsZzTzYxSKg65Ooo3Zt1VS2T\nFChR48L7LZ5ECrFGwSAp6TU2nlq0utg4PtqpbFtX2wKBgQDsArilP3Nt/Iv75UVB\nYEXWgg2su2vR2P3Q5YW+TciMBzrOjzcL1WP/0Khx35k0ndz02DosplJTQyniki4n\noGZcmxpYxfXNAvJnIkcDeO8jQ22gu75yqOOcqPnlOM2JJlSbocn8fLJWtoPxAOCR\nHr0y36W9r86zpJvAIi0WD7MNYwKBgQC5ary5SEAAxEmcSvy2Idr3MCu+vGFe8E4N\nfAKK/lWpZXGbW4+pDSILXKcSheam5cgWBhPew9WATrNTBR7KtMRrm5OS2JZ13Vhq\nj0WXbZIKnxdZut+dcTUkG9uw8tKqUFwJtcm+6fyQVZuiB3zIkDh7MQ7uj1EsBhZ8\n+KBjKEIAvwKBgQCjRiKtl57omU3Sn0NxPgQyqViChkrKK1801ITZKgCy9xF081k2\no5MB2D2gQftAjnHdJXXhi9LqbU2dxFmP6oTGTjtE7PbmtMI0HV+ZhGGUOMKv7xKL\nSlHlAHWZYdm3pz/jR2NwfGf4W14eLeguHWDwwA5ukyDh4OArZLliSMwrVwKBgGI2\ncYTLCmvdjQgmiDmJMUzhzSoY6pK5Qv7NgyNQmNtDiqu6Ehx/glr2VuDu4D/jUtqn\nmXrTzJFMHpyJB8hje+9r1v1fkEMaXa0D+t69ATBzGJFE9RGWV4mq3/GYjZH9QuM5\n0YU4t7lUPz3SLXynN+O5FqmybFKfXuYPZBVhy6RNAoGAOWVnJ9k1ThQYl2sqPWk+\nwBCP/JsMRw+uyd9AWm9zWjYG2BHBDq/AqKH/2nlV8tAEuVP+1Mo0fS5a4ddKxH9b\n8HvZ/UWawvm3x1rtbZMGwRkvzSumE74DHJYIhH6m/GSHuXsPGjRuUDmFxMcYfsCr\nLP0fDO4FB1YmEJ5qkj3nT0I=\n-----END PRIVATE KEY-----\n","client_email":"kongsecret@warren-personal.iam.gserviceaccount.com","client_id":"116540807013833941361","auth_uri":"https://accounts.google.com/o/oauth2/auth","token_uri":"https://oauth2.googleapis.com/token","auth_provider_x509_cert_url":"https://www.googleapis.com/oauth2/v1/certs","client_x509_cert_url":"https://www.googleapis.com/robot/v1/metadata/x509/kongsecret%40warren-personal.iam.gserviceaccount.com"}]]
  local jwtToken = GetJwtToken(gcpServiceAccount)
  local response = GetAccessTokenByJwt(jwtToken)
  self.token = response.access_token
  self.expireTime = ngx.now() + response.expires_in

  return self
end

function Hardcoded:refresh()
  local gcpServiceAccount = [[{"type":"service_account","project_id":"warren-personal","private_key_id":"58a5c04d057fc0d33cabc940a0d6a52871adf8f7","private_key":"-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCq8F6Mr3M/nEQF\ngQqi9n1nMyMLJtTP/YILTGH7tYXBbw7ya8kjGPo0FLhq5eClGmF26ck6REkqTfE+\nNil6+N3k6tmYYcogqPSi3tUxPXUb/oxbAr2GPRGkQ5Ek3RsjSma1fB8nGmByqjIb\nBMWOkKEDUX/OgIKu51RYwk8arFA9w90P08UTLaBSSmUy+j6Id15Nb0FNuo1cmRz7\njQePrptl604F7s43wAinlr1DO1x5eRUJL1OdDdbPGh2D5EqLeqDXxrk8PXMd/pFj\nbjxdEz1ipgmJLu8Em2cdR3P/STfbOZMYw28Du9Dw79DBIOjMwSFPNdQKMEtR2lIn\ntv+iHPzdAgMBAAECggEADxHArBNdjBqJDpkpKGOle38RFE8YjLtzBu71ZlzCzWIu\nhaWF5k+x4vx+o4Hfc36nX/XNNRNHBfE4Fr1sm7gry53+j8XzLTzn0CHn1n7t/4lJ\ns05DCf4BO6NvPLo3Rb2t30rxbh+PqBwj7ajWh7JtV18MbtZ6btPa5jY/BgFx03f3\nMpuy25Hqo8GRvy8ip8bi2aP91W2m7x9sqORJJ6inrLjkIBbBYPeLRofX1ghNHp7S\nRKR2mnIXkAL6CSvwbV1NoioPGls//viFKjfTZaILtsZzTzYxSKg65Ooo3Zt1VS2T\nFChR48L7LZ5ECrFGwSAp6TU2nlq0utg4PtqpbFtX2wKBgQDsArilP3Nt/Iv75UVB\nYEXWgg2su2vR2P3Q5YW+TciMBzrOjzcL1WP/0Khx35k0ndz02DosplJTQyniki4n\noGZcmxpYxfXNAvJnIkcDeO8jQ22gu75yqOOcqPnlOM2JJlSbocn8fLJWtoPxAOCR\nHr0y36W9r86zpJvAIi0WD7MNYwKBgQC5ary5SEAAxEmcSvy2Idr3MCu+vGFe8E4N\nfAKK/lWpZXGbW4+pDSILXKcSheam5cgWBhPew9WATrNTBR7KtMRrm5OS2JZ13Vhq\nj0WXbZIKnxdZut+dcTUkG9uw8tKqUFwJtcm+6fyQVZuiB3zIkDh7MQ7uj1EsBhZ8\n+KBjKEIAvwKBgQCjRiKtl57omU3Sn0NxPgQyqViChkrKK1801ITZKgCy9xF081k2\no5MB2D2gQftAjnHdJXXhi9LqbU2dxFmP6oTGTjtE7PbmtMI0HV+ZhGGUOMKv7xKL\nSlHlAHWZYdm3pz/jR2NwfGf4W14eLeguHWDwwA5ukyDh4OArZLliSMwrVwKBgGI2\ncYTLCmvdjQgmiDmJMUzhzSoY6pK5Qv7NgyNQmNtDiqu6Ehx/glr2VuDu4D/jUtqn\nmXrTzJFMHpyJB8hje+9r1v1fkEMaXa0D+t69ATBzGJFE9RGWV4mq3/GYjZH9QuM5\n0YU4t7lUPz3SLXynN+O5FqmybFKfXuYPZBVhy6RNAoGAOWVnJ9k1ThQYl2sqPWk+\nwBCP/JsMRw+uyd9AWm9zWjYG2BHBDq/AqKH/2nlV8tAEuVP+1Mo0fS5a4ddKxH9b\n8HvZ/UWawvm3x1rtbZMGwRkvzSumE74DHJYIhH6m/GSHuXsPGjRuUDmFxMcYfsCr\nLP0fDO4FB1YmEJ5qkj3nT0I=\n-----END PRIVATE KEY-----\n","client_email":"kongsecret@warren-personal.iam.gserviceaccount.com","client_id":"116540807013833941361","auth_uri":"https://accounts.google.com/o/oauth2/auth","token_uri":"https://oauth2.googleapis.com/token","auth_provider_x509_cert_url":"https://www.googleapis.com/oauth2/v1/certs","client_x509_cert_url":"https://www.googleapis.com/robot/v1/metadata/x509/kongsecret%40warren-personal.iam.gserviceaccount.com"}]]
  local jwtToken = GetJwtToken(gcpServiceAccount)
  local response = GetAccessTokenByJwt(jwtToken)
  self.token = response.access_token
  self.expireTime = ngx.now() + response.expires_in
  self:set(access, secret, token, expire)
  return true
end

return Hardcoded
