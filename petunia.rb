require 'sinatra'
require 'json'

get '/' do
  "Hello, Universe!"
end

post '/' do
  data = JSON.parser(request.body)
  logger.info(data)
end
