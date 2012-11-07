

####This is a small server to response and to see wether a post org get works
#
#



require 'sinatra'    
get '/' do  
      "Hello, World!"  
    end 

post '/service' do
content_type :xml
    request.body
end
