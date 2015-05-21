require 'sinatra'
require 'json'

get '/' do
  "Hello, Universe!"
end

post '/' do
  data = JSON.parse(request.body)
  logger.info(data)
end
