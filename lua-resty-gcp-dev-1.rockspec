package = "lua-resty-gcp"
version = "dev-1"
source = {
   url = "*** please add URL for source tarball, zip or repository here ***"
}
description = {
   homepage = "*** please enter a project homepage ***",
   license = "*** please specify a license ***"
}
build = {
   type = "builtin",
   modules = {
      ["resty.gcp.init"]                                = "src/resty/gcp/init.lua",
      ["resty.gcp.request.http.http"]                   = "src/resty/gcp/request/http/http.lua",
      ["resty.gcp.request.http.socket"]                 = "src/resty/gcp/request/http/socket.lua",
      ["resty.gcp.request.credentials.accesstoken"]     = "src/resty/gcp/request/credentials/accesstoken.lua",
   
      ["resty.aws.api.secretmanager"]                   = "src/resty/gcp/api/secretmanager.lua",
   }
}
