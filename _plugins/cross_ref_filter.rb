module Jekyll
  module CrossRefFilter
    def resolve_cross_refs(input, url)
      # posts can point to next post
      current_post = @context.registers[:site].posts.select { |p| "#{url}" == "#{p.url}" }[0]

      next_post_repl = next_post_cat_repl = '#'
      if (next_post = current_post.next)
        next_post_repl = current_post.next.url

        found_cat_succ = false
        while next_post and !found_cat_succ do
          diff = next_post.categories - current_post.categories
          puts "Checking #{diff}"
          if diff.count != next_post.categories.count # something from the current post was in the next post
            found_cat_succ=true
            next_post_cat_repl = next_post.url
          else
            next_post = next_post.next
          end
        end
      end        

      input = input.gsub(/%3C%20next_post%20%3E/, next_post_repl)
      input.gsub(/%3C%20next_post_by_cat%20%3E/, next_post_cat_repl)
      # 
    end
  end
end

Liquid::Template.register_filter(Jekyll::CrossRefFilter)
