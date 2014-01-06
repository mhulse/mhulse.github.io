# Generate bit.ly links on the fly
# Can be used anywhere liquid syntax is parsed (templates, includes, posts/pages).
# 
# Usage: [Bit.ly gem]({{ 'https://github.com/philnash/bitly' | bitly }})
# 
# Copyright (c) 2012, Xorcode LLC.
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met: 
# 
# 1. Redistributions of source code must retain the above copyright notice, this
#    list of conditions and the following disclaimer. 
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution. 
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
# 
# The views and conclusions contained in the software and documentation are those
# of the authors and should not be interpreted as representing official policies, 
# either expressed or implied, of Xorcode, LLC.

require 'bitly'

module Jekyll
  class BitlyFilterCache
    def initialize
      @result_cache = {}
      config = Jekyll.configuration({})
      @username = config['bitly']['username']
      @key = config['bitly']['api_key']
      Bitly.use_api_version_3
    end

    @@instance = BitlyFilterCache.new

    def self.instance
      @@instance
    end

    def shorten(input)
      input.strip!
      return @result_cache[input] if @result_cache.has_key?(input)
      bitly = Bitly.new(@username, @key)
      u = bitly.shorten(input, :history => 1)
      @result_cache[input] = u.short_url
      return u.short_url
    end
  end

  module Filters
    def bitly(input)
      BitlyFilterCache.instance.shorten(input)
    end
  end
end
