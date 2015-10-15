require 'uri'

query = `pbpaste`

xml_string = "<?xml version=\"1.0\"?>\n<items>\n"

begin
	link = query
        unless link[/\Ahttp:\/\//] || link[/\Ahttps:\/\//]
            link = "http://#{link}"
        end
    
	url = URI(link)
	host = url.host
	domain = host
	if domain =~ /(?:[\da-z\-]+\.)?([\da-z\-]+)\.(?:[a-z\.]{2,6})(?:[\/\w \.-]*)*\/?$/i
		domain = $1
	end
	port = url.port
	path = url.path

	host_xml = "\t<item uid=\"#{host}\" arg=\"#{host}\">
				<title>#{host}</title>
				<subtitle>Press ENTER to copy Host: \'#{host}\' to clipboard</subtitle>
				<icon>icon.png</icon>
				</item>\n"
	xml_string += host_xml
	
	domain_xml = "\t<item uid=\"#{domain}\" arg=\"#{domain}\">
				<title>#{domain}</title>
				<subtitle>Press ENTER to copy Domain: \'#{domain}\' to clipboard</subtitle>
				<icon>icon.png</icon>
				</item>\n"
	xml_string += domain_xml

	port_xml = "\t<item uid=\"#{port}\" arg=\"#{port}\">
				<title>#{port}</title>
				<subtitle>Press ENTER to copy Port: \'#{port}\' to clipboard</subtitle>
				<icon>icon.png</icon>
				</item>\n"
	xml_string += port_xml

	path_xml = "\t<item uid=\"#{path}\" arg=\"#{path}\">
				<title>#{path}</title>
				<subtitle>Press ENTER to copy Path: \'#{path}\' to clipboard</subtitle>
				<icon>icon.png</icon>
				</item>\n"
	xml_string += path_xml

rescue => e
	none_xml = "\t<item uid=\"none\" arg=\"none\">
				<title>No Suggestions</title>
				<subtitle>Copy valid URL and type uri to see output</subtitle>
				<icon>icon.png</icon>
				</item>\n"
	xml_string += none_xml
end

xml_string += "</items>"
puts xml_string
