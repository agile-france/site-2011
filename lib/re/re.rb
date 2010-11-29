module Re
  
  # builds a regexp out of a string, as interpreted in irb
  # parse("/hello/i") is /hello/i
  def parse(string)
    md = %r{^/(.*)/(\w+)?$}.match(string)
    Regexp.new(md[1], options(md[2])) if md
  end
  
  # turn string modifiers used in regexp modifier (/mix), as regexp options (that is an int with bit options)
  # 
  def options(modifiers)
    return 0 unless modifiers
    letters = modifiers.chars.to_a.select { |c| whitelist.include?(c)}.uniq
    letters.reduce(0) {|bit, letter|
      bit |= case letter
        when 'm' then Regexp::MULTILINE
        when 'i' then Regexp::IGNORECASE
        when 'x' then Regexp::EXTENDED
      end 
    }
  end
  
  def whitelist
    %w(m i x)
  end
  module_function :parse, :options, :whitelist
end