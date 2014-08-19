# Replaces multiple newlines and whitespace
# between them with one newline
module Jekyll
  class StripTag < Liquid::Block
    def render(context)
      super
        .strip
        .gsub(/\n/, " ")
        .gsub(/\s{2,}/, " ")
        .gsub(/…\s*/, "… ")
    end
  end
end
Liquid::Template.register_tag('strip', Jekyll::StripTag)
