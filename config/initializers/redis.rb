$redis = Redis.new
## url = "redis://default:wFob4MQ1gr4ntgZMzHx4eThGaEjsyBk4@redis-17689.c270.us-east-1-3.ec2.cloud.redislabs.com:17689"
url = "redis://default:Ge42H55fUrH8hfukHFXTDebvu2RcLdcV@redis-10527.c84.us-east-1-2.ec2.cloud.redislabs.com:10527"

if url

  $redis = Redis.new(:url => url)
end
