require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/json'
require 'json'

get '/' do
  'Hello, Universe!'
end

$STUDENTS = []

post '/' do
  data = JSON.parse(request.body.read)
  logger.info(data)

  output = "You know nothing, Jon Snow."

  r = data["request"]

  if r["type"] == "IntentRequest"
    case r["intent"]["name"]
      when "ListStudents"
        output = "There are #{$STUDENTS.size} students. #{$STUDENTS.join(', ')}"
      when "AddStudent"
        name = r["intent"]["slots"]["Student"]["value"]
        $STUDENTS << name
        output = "Ok. I'll add #{name} to the list. There are now #{$STUDENTS.size} students."
    end
  end

  json({version: '1.0',
        response: {
            outputSpeech: {
                type: 'PlainText',
                text: output
            },
            shouldEndSession: true
        }
       })

end
