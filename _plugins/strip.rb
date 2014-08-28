# Replaces multiple newlines and whitespace
# between them with one newline
module Jekyll
  class StripTag < Liquid::Block
    def render(context)
      super
        .strip
        .gsub(/\n/, "\s")
        .gsub(/\s{2,}/, "\s")
        .gsub(/[…\s]{2,}/, "\s…\s")
    end
  end
end
Liquid::Template.register_tag('strip', Jekyll::StripTag)
