module Jekyll
  module CrossRefFilter
    def resolve_cross_refs(input, url)
      # posts can point to next post
      current_post = @context.registers[:site].posts.select { |p| "#{url}" == "#{p.url}" }[0]

      prev_post_repl = next_post_repl = prev_post_cat_repl = next_post_cat_repl = '#'

      # Walk forward, ... 
      if (next_post = current_post.next)
        next_post_repl = current_post.next.url

        found_cat_succ = false
        while next_post and !found_cat_succ do
          diff = next_post.categories - current_post.categories
          if diff.count != next_post.categories.count # something from the current post was in the next post
            found_cat_succ=true
            next_post_cat_repl = next_post.url
          else
            next_post = next_post.next
          end
        end
      end        

      # And then backwards.
      if (prev_post = current_post.previous)
        next_post_repl = current_post.previous.url

        found_cat_pred = false
        while prev_post and !found_cat_pred do
          diff = prev_post.categories - current_post.categories
          if diff.count != prev_post.categories.count # something from the current post was in the prev post
            found_cat_pred=true
            prev_post_cat_repl = prev_post.url
          else
            prev_post = prev_post.previous
          end
        end
      end        

      input = input.gsub(/\-\-next_post\-\-/, next_post_repl)
      input = input.gsub(/\-\-next_post_by_cat\-\-/, next_post_cat_repl)


      input = input.gsub(/\-\-prev_post\-\-/, prev_post_repl)
      input = input.gsub(/\-\-prev_post_by_cat\-\-/, prev_post_cat_repl)
    end
  end
end

Liquid::Template.register_filter(Jekyll::CrossRefFilter)
