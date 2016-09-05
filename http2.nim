import httpClient,os,json,strutils
proc http_get(url:cstring) :cstring {.gcsafe,exportc: "http_get".} =
  var body:string
  body = getContent($url,timeout = -1,
    userAgent = defuserAgent, proxy = nil)
  echo body
  if body != nil:
    return cstring(body)