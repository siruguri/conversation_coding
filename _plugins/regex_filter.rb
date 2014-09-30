module Jekyll
  module RegexFilter
    def replace_regex(input, reg_str, repl_str)
      re = Regexp.new reg_str

      # This will be returned
      a=input.gsub re, repl_str
      puts ">>> #{reg_str}, #{a}"
      a
    end
  end
end

Liquid::Template.register_filter(Jekyll::RegexFilter)
