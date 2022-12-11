module Public::PostsHelper
  def render_with_hashtags(body)
    body.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/){|word| link_to word, "/posts/tag/#{word.delete("#")}"}.html_safe
  end
  
end
