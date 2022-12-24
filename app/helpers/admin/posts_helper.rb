module Admin::PostsHelper
   def admin_render_with_hashtags(body)
    body.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/){|word| link_to word, "/admin/posts/tag/#{word.delete("#")}"}.html_safe
  end
end
