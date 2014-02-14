module Jekyll
  
  class Fig < Liquid::Tag
    
    def initialize(tag_name, markup, tokens)
      @markup = markup
      super
    end
    
    def render(context)
      
      render_markup = Liquid::Template.parse(@markup).render(context).gsub(/\\\{\\\{|\\\{\\%/, '\{\{' => '{{', '\{\%' => '{%')
      
      site = context.registers[:site]
      
      # Throw error if uploads not set.
      
      page = context.registers[:page]
      
      markup = /^(?:(?<key>[^\s]+)\s+)?\s*(?<attr>[\s\S]+)?$/.match(render_markup)
      
      settings = page[markup[:key]]
      
      instance = Marshal.load(Marshal.dump(settings))
      
      #puts instance
      
      attr = if markup[:attr]
        Hash[*markup[:attr].scan(/(?<attr>[^\s="]+)(?:="(?<value>[^"]+)")?\s?/).flatten]
      else
        {}
      end
      
      if instance['attr']
        attr = instance.delete('attr').merge(attr)
      end
      
      attr_string = attr.inject('') { |string, attrs|
        if attrs[1]
          string << "#{attrs[0]}=\"#{attrs[1]}\" "
        else
          string << "#{attrs[0]} "
        end
      }
      
      generate_figure(instance, attr_string, site)
      
    end
    
    def generate_figure(instance, attr_string, site)
      
      converter = site.getConverterImpl(::Jekyll::Converters::Markdown)
      uploads_fqdn = site.config['uploads']
      
      _output = "<figure"
      _output += " id=\"#{instance[:id]}\"" if instance[:id]
      _output += " class=\"#{instance[:class]}\"" if instance[:class]
      _output += ">"
      _output += "<div class=\"#{instance[:wrap]}\">" if instance[:wrap]
      
      # if _kind.to_s.downcase == "iframe"
        
      # elsif _kind.to_s.downcase == "audio"
        
      # elsif _kind.to_s.downcase == "video"
        
      # else
        
      # end
      
      _output += "</div>" if instance[:wrap]
      _output += "<figcaption>#{converter.convert(instance[:caption])}</figcaption>" if instance[:caption]
      _output += "</figure>"
      
    end
    
    def generate_image()
      
    end
    
    def generate_video()
      
    end
    
    def generate_audio()
      
    end
    
    def generate_iframe()
      
    end
    
    def generate_caption()
      
    end
    
  end
  
end

Liquid::Template.register_tag('fig', Jekyll::Fig)
