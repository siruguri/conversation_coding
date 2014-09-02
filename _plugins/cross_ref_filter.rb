module Jekyll
  module CrossRefFilter
    def resolve_cross_refs(input, url)
      # posts can point to next post
      current_post = @context.registers[:site].posts.select { |p| "#{url}" == "#{p.url}" }[0]

      if current_post.next
        repl = current_post.next.url
      else
        repl = input.gsub(/<< next_post >>/, '#')
      end        

      input.gsub(/%3C%20next_post%20%3E/, repl)
      # 
    end
  end
end

Liquid::Template.register_filter(Jekyll::CrossRefFilter)
