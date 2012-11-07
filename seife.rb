
#This programm ist for testing http servers like soap servers
#It generates requests from a templatefile. 
#It fires as many times as you define here
#The inputfile runs first thru ERB the modify the content

require 'net/http'
require 'erb'

class SoapHelper

    def create_outputrequest
        output_xml=File.read("request.xml")
        output_xml
    end


    def do_it
        #here modify how often the request is fired to the server
        10.times do |x|
         #this variable is an example define here the variables you want to modify in the soap request
         #This variable is available in the requestfile as <%=trans_id%>
            trans_id = (121212 + x).to_s
            template = create_outputrequest
            erb = ERB.new(template)
            output_xml = erb.result( binding )
            post_xml("localhost","4567","/service",output_xml)
        end
    end
    def post_xml(host,port,path, xml)
        http = Net::HTTP.new(host,port)
        puts ">>>>>>>>>>>>>>>>>>>"
        puts xml.inspect
        puts "<<<<<<<<<<<<<<<<<<"
        ##Ensure that your file is utf-8 - this is often a problem on windows platforms
        resp = http.post(path, xml, { 'Content-Type' => 'application/soap+xml; charset=utf-8' })
        puts resp.body.inspect
        return resp.body
    end
end

SoapHelper.new.do_it


