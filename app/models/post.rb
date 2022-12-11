class Post < ApplicationRecord

  belongs_to :user
  has_many :post_tags
  has_many :tags ,through: :post_tags
  

  enum status: { "公開": 0, "下書き": 1 }

  after_create do
    post = Post.find_by(id: self.id)
    tags  = self.body.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    post.tags = []
    tags.uniq.map do |tag|
      #ハッシュタグは先頭の'#'を外した上で保存
      hashtag = Tag.find_or_create_by(name: tag.downcase.delete('#'))
    post.tags << hashtag
    end
  end

  before_update do
    post = Post.find_by(id: self.id)
    post.tags.clear
    tags = self.caption.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    tags.uniq.map do |tag|
      tag = Tag.find_or_create_by(name: tag.downcase.delete('#'))
      post.tags << tag
    end
  end
end
