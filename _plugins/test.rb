module Jekyll
  
  # I have come here to chew bubblegum and kick ass ...
  # ... and I'm all out of bubblegum.
  class Nada < Liquid::Tag
    
    # Internal globals:
    NS = 'nada'                # Namespace.
    INCLUDES_DIR = '_includes' # Includes folder.
    
    def initialize(tag_name, markup, tokens)
      
      # Instance variable(s):
      @markup = markup
      
      # Call parent:
      super
      
    end
    
    def render(context)
      
      # Get `site` and `page` hashes:
      site = context.registers[:site]
      page = context.registers[:page]
      
      # Render liquid variables:
      render_markup = Liquid::Template.parse(@markup).render(context).gsub(/\\\{\\\{|\\\{\\%/, '\{\{' => '{{', '\{\%' => '{%')
      
      # Regex to match expected tag syntax:
      markup = /^(?:(?<key>^\s*([[:alnum:]]+)?\s*)\s+)?\s*(?<options>[\s\S]+)?$/.match(render_markup)
      
      # Raise an exception if tag syntax is bad:
      raise "\"%s\" tag syntax error. Try {% %s [front matter key (optional)] [override=\"value\" (optional)] %}." % [NS.capitalize, NS] unless markup
      
      if not markup[:key].nil?
        
        # Get the page front matter settings for `key`:
        key = page[markup[:key]]
        
        # Raise an exception if `key` not found:
        raise "\"%s\" tag could not find a front matter key named \"%s\"." % [NS.capitalize, markup[:key]] unless key
        
      end
      
      # Options (`foo="bar"`) found tag?
      options = if markup[:options]
        
        # Yup, convert and return `options` as hash:
        Hash[*markup[:options].scan(/(?<option>[^\s="]+)(?:="(?<value>[^"]+)")?\s?/).flatten]
        
      else
        
        # Nope, set `options` as empty hash:
        {}
        
      end
      
      # Get at front matter via `key`?
      settings = if key
        
        # Yes, so deep copy preset for single instance manipulation:
        Marshal.load(Marshal.dump(key)) # Front matter defaults.
        
      else
        
        # Nope, set `settings` as empty hash:
        {}
        
      end
      
      # Merge `settings` with `options`:
      settings.merge!(options) # Allow `options` to override `defaults`, "in place".
      
      # If not template specified, use `nada.html` as a default:
      settings['template'] ||= 'nada.html'
      
      # Raise an exception if no template was specified:
      #raise "\"%s\" tag couldn't find a template." % [NS.capitalize] unless settings['template']
      
      # Find template:
      file_dir = File.join(site.source, INCLUDES_DIR)
      file_path = Pathname.new(file_dir).expand_path
      file = file_path + settings['template']
      
      raise "\"%s\" tag could not find file: \"%s\"." % [NS.capitalize, file] unless file.file?
      
      # Change the CWD of the process to `file_path`:
      Dir.chdir(file_path) do
        
        # Parse template part:
        partial = Liquid::Template.parse(file.read)
        
        # ?
        context.stack do
          
          # Add `settings` to `context` for use on liquid template:
          context[NS] = settings
          
          # Render `context` to liquid template:
          partial.render!(context)
          
        end
        
      end
      
    end
    
  end
  
end

# Register liquid tag with Jekyll:
Liquid::Template.register_tag('nada', Jekyll::Nada)
