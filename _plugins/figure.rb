# Inspired by:
# * https://github.com/opattison/jekyll-figure-image-tag
# * https://github.com/stewart/blog/blob/master/plugins/image_tag.rb
#
# Define in _config.yml:
#
# uploads: http://uploads.example.com
#
# Example post front matter:
#
# ---
# image1:
#   src: 'foo.png'
#   caption: 'Lorem ipsum dolor sit.'
#   id: 'foo'
#   class: 'bar other'
#   wrap: 'baz'
#   alt: 'Billy'
# ---
#
# Example call:
#
# {% figure image1 %}
#
# Output:
#
# <figure id="foo" class="bar other"><div class="baz"><img src="http://uploads.mky.io/foo.png" alt="Billy"></div><figcaption>Lorem ipsum dolor sit.</figcaption></figure>

module Jekyll
  
  class FigureTag < Liquid::Tag
    
    def initialize(tag_name, text, tokens)
      
      super
      
      @text = text
      
    end
    
    def render(context)
      
      if parts = @text.match(/([^\s]+)/)
        
        _uploads = context.registers[:site].config['uploads']
        _figure = context.registers[:page][parts[1].strip]
        
        _src = _figure['src']
        _alt = _figure['alt']
        _caption = _figure['caption']
        _class = _figure['class']
        _id = _figure['id']
        _wrap = _figure['wrap']
        
        _output = "<figure"
        _output += " id=\"#{_id}\"" if _id
        _output += " class=\"#{_class}\"" if _class
        _output += ">"
        _output += "<div class=\"#{_wrap}\">" if _wrap
        _output += "<img src=\"#{_uploads}\/#{_src}\" alt=\"#{_alt}\">"
        _output += "</div>" if _wrap
        _output += "<figcaption>#{_caption}</figcaption>" if _caption
        _output += "</figure>"
        
      else
        
        ""
        
      end
        
    end
    
  end
  
end

Liquid::Template.register_tag('figure', Jekyll::FigureTag)
