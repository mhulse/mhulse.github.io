module Jekyll
  
  class Test < Liquid::Tag
    
    INCLUDES_DIR = '_includes'
    
    def initialize(tag_name, markup, tokens)
      @markup = markup
      super
    end
    
    def render(context)
      
      page = context.registers[:page]
      site = context.registers[:site]
      
      render_markup = Liquid::Template.parse(@markup).render(context).gsub(/\\\{\\\{|\\\{\\%/, '\{\{' => '{{', '\{\%' => '{%')
      markup = /^(?:(?<key>[^\s]+)\s+)?\s*(?<attr>[\s\S]+)?$/.match(render_markup)
      
      attr = if markup[:attr]
        Hash[*markup[:attr].scan(/(?<attr>[^\s="]+)(?:="(?<value>[^"]+)")?\s?/).flatten]
      else
        {}
      end
      
      settings = page[markup[:key]]
      instance = Marshal.load(Marshal.dump(settings))
      instance.merge(attr)
      
      file_dir = File.join(site.source, INCLUDES_DIR)
      file_path = Pathname.new(file_dir).expand_path
      file = file_path + instance['template']
      
      raise "File #{file} could not be found." unless file.file?
      
      Dir.chdir(file_path) do
        
        contents = file.read
        
        partial = Liquid::Template.parse(contents)
        
        context.stack do
          
          context['fig'] = instance
          partial.render(context)
          
        end
        
      end
      
    end
    
  end
  
end

Liquid::Template.register_tag('test', Jekyll::Test)
