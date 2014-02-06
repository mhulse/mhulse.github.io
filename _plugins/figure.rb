# Inspired by:
# * https://github.com/opattison/jekyll-figure-image-tag
# * https://github.com/stewart/blog/blob/master/plugins/image_tag.rb
#
# Define in _config.yml:
#
# uploads: http://uploads.example.com/
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
#
# @todo use templates from filesystem for the various types of output.

module Jekyll
  
  class FigureTag < Liquid::Tag
    
    def initialize(tag_name, text, tokens)
      
      super
      
      @text = text
      
    end
    
    def render(context)
      
      site = context.registers[:site]
      converter = site.getConverterImpl(::Jekyll::Converters::Markdown)
      
      _type = {
        'mp4' => 'video/mp4',
        'ogv' => 'video/ogg',
        'webm' => 'video/webm',
        'ogg' => 'audio/ogg',
        'mp3' => 'audio/mpeg',
      }
      
      if parts = @text.match(/([^\s]+)/) # Continue only if the assignmet of `parts` returns a match.
        
        _uploads = context.registers[:site].config['uploads']
        _figure = context.registers[:page][parts[1].strip]
        
        _alt = _figure['alt']
        _caption = _figure['caption']
        _class = _figure['class']
        _files = _figure['files']
        _height = _figure['height']
        _id = _figure['id']
        _kind = _figure['kind']
        _src = _figure['src']
        _width = _figure['width']
        _wrap = _figure['wrap']
        
        _output = "<figure"
        _output += " id=\"#{_id}\"" if _id
        _output += " class=\"#{_class}\"" if _class
        _output += ">"
        _output += "<div class=\"#{_wrap}\">" if _wrap
        if _kind.to_s.downcase == "iframe"
          _output += "<iframe "
          _output += "width=\"#{_width}\" " if _width
          _output += "height=\"#{_height}\" " if _height
          _output += "src=\"#{_src}\" "
          _output += "marginheight=\"0\" marginwidth=\"0\" frameborder=\"0\" scrolling=\"no\" webkitallowfullscreen mozallowfullscreen allowfullscreen"
          _output += "></iframe>"
        elsif _kind.to_s.downcase == "audio"
          _output += "<audio preload=\"none\" controls>"
          _files.each do |_value|
            _ext = _value.match(/([^\.]+)$/)[1]
            _output += "<source src=\"#{_uploads}\/#{_value}\""
            _output += " type=\"#{_type[_ext]}\"" if _ext
            _output += ">"
          end
          _output += "</audio>"
        else
          _output += "<img src=\"#{_uploads}#{_src}\" alt=\"#{_alt}\" width=\"#{_width}\" height=\"#{_height}\">"
        end
        _output += "</div>" if _wrap
        _output += "<figcaption>#{converter.convert(_caption)}</figcaption>" if _caption
        _output += "</figure>"
        
      else
        
        ""
        
      end
        
    end
    
  end
  
end

Liquid::Template.register_tag('figure', Jekyll::FigureTag)
