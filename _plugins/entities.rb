require 'cgi'

module Entities
  
  def encode(input)
    CGI.escapeHTML(input)
  end
  
  def decode(input)
    CGI.unescapeHTML(input)
  end
  
  Liquid::Template.register_filter self
  
end
