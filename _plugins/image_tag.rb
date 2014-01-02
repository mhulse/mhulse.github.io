# Image tag.
# Easily put an image into a Jekyll page or blog post.
#
# Original: https://github.com/stewart/blog/blob/master/plugins/image_tag.rb
#
# Examples:
#
#   Input:
#     {% image http://path/to/image.png %}
#   Output:
#      <figure>
#        <img src='http://path/to/image.png'>
#      </figure>
#
#   Input:
#     {% image full http://path/to/image.png %}
#   Output:
#      <figure class='full'>
#        <img src="http://path/to/image.png">
#      </figure>
#
#   Input:
#     {% image http://path/to/image.png "Image caption" %}
#   Output:
#      <figure>
#        <img src="http://path/to/image.png">
#        <figcaption>Image caption</figcaption>
#      </figure>
#
#   Input:
#     {% image full http://path/to/image.png "Image caption" %}
#   Output:
#      <figure class='full'>
#        <img src="http://path/to/image.png">
#        <figcaption>Image caption</figcaption>
#      </figure>

module Jekyll
  
  class ImageTag < Liquid::Tag
    
    @url     = nil
    @caption = nil
    @class   = nil
    
    IMAGE_URL_WITH_CLASS_AND_CAPTION = /(\w+)(\s+)((https?:\/\/|\/)(\S+))(\s+)"(.*?)"/i
    IMAGE_URL_WITH_CAPTION           = /((https?:\/\/|\/)(\S+))(\s+)"(.*?)"/i
    IMAGE_URL_WITH_CLASS             = /(\w+)(\s+)((https?:\/\/|\/)(\S+))/i
    IMAGE_URL                        = /((https?:\/\/|\/)(\S+))/i
    
    def initialize(tag_name, markup, tokens)
      
      super
      
      if markup =~ IMAGE_URL_WITH_CLASS_AND_CAPTION
        @class   = $1
        @url     = $3
        @caption = $7
      
      elsif markup =~ IMAGE_URL_WITH_CAPTION
        @url     = $1
        @caption = $5
      
      elsif markup =~ IMAGE_URL_WITH_CLASS
        @class = $1
        @url   = $3
      
      elsif markup =~ IMAGE_URL
        @url = $1
      
      end
      
    end
    
    def render(context)
      
      source = "<figure>"
      source += "<div class=\"#{@class}\">" if @class
      source += "<img src=\"#{@url}\">"
      source += "</div>" if @class
      source += "<figcaption>#{@caption}</figcaption>" if @caption
      source += "</figure>"
      source
      
    end
    
  end
  
end

Liquid::Template.register_tag('image', Jekyll::ImageTag)
