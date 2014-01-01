# http://zpao.com/posts/adding-line-highlights-to-markdown-code-fences/
# http://pygments.org/docs/formatters/
# https://github.com/mhulse/picard/issues/116
#
# Replace Jekyll's handling of the Redcarpet code_block (which already adds
# support for highlighting, but needs support for the very non-standard
# "code fences with line highlights" extension).
# Since this is currently depending on Redcarpet to cooperate, we are going to
# be naive, and only allow line highlighting when a language is specified. If
# you don't want any syntax highlighting but want to highlight lines, then you
# need to specify text as your language (or it will break), like:
# ```text{4}

module Jekyll
  module Converters
    class Markdown
      class RedcarpetParser
        module CommonMethods
          def customize(code, lang)
            # code = code.sub(/<pre>/, "<pre class=\"#{lang} language-#{lang}\" data-lang=\"#{lang}\">")
            code = code.gsub(" class=\"code\"", "")
            "<div class=\"pygments x6\">#{code}</div>"
          end
        end
        module WithPygments
          def block_code(code, lang)
            require 'pygments'
            # require 'securerandom'
            lang_parts = lang && lang.split('{')
            lang = lang_parts && !lang_parts[0].empty? && lang_parts[0] || 'text'
            hl_lines = ''
            if lang_parts && lang_parts.size >= 2
              hl_lines = lang_parts[1].gsub(/[{}]/, '').split(',').map do |ln|
                if matches = /(\d+)-(\d+)/.match(ln)
                  ln = Range.new(matches[1], matches[2]).to_a.join(' ')
                end
                ln
              end.join(' ')
            end
            output = customize(
              Pygments.highlight(code,
                :lexer => lang,
                :options => {
                  :encoding => 'utf-8',
                  :hl_lines => hl_lines,
                  :cssclass => 'pyg',
                  :linenos => 'table',
                  # :lineanchors => 'X' + SecureRandom.hex(1).to_s.upcase,
                  # :anchorlinenos => true,
                }
              ),
              lang
            )
          end
        end
      end
    end
  end
end
