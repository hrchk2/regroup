class Post < ApplicationRecord

  belongs_to :user
  has_many :post_tags, dependent: :destroy
  has_many :tags ,through: :post_tags
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :participants,dependent: :destroy

  enum status: { "公開": 0, "下書き": 1 }

  validates :title, presence: true,length: { minimum: 2 }
  validates :body, presence: true,length: { minimum: 2 }

  after_create do
    post = Post.find_by(id: self.id)
    tags  = self.body.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    post.tags = []
    tags.uniq.map do |tag|
      #ハッシュタグは先頭の'#'を外した上で保存
      hashtag = Tag.find_or_create_by(name: tag.downcase.delete('#').delete('＃'))
    post.tags << hashtag
    end
  end

  before_update do
    post = Post.find_by(id: self.id)
    post.tags.clear
    tags = self.body.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    tags.uniq.map do |tag|
      hashtag = Tag.find_or_create_by(name: tag.downcase.delete('#').delete('＃'))
      post.tags << hashtag
    end
  end

  # userがいいねしているかどうか判定
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.looks(search, word, range)
    if range == "Post"
      if search == "perfect_match"
        where("title LIKE?", "#{word}")
      elsif search == "forward_match"
        where("title LIKE?","#{word}%")
      elsif search == "backward_match"
        where("title LIKE?","%#{word}")
      elsif search == "partial_match"
        where("title LIKE?","%#{word}%")
      else
        self
      end
    elsif range == "Tag"
      if search == "perfect_match"
        tags = Tag.where("name LIKE?", "#{word}")
      elsif search == "forward_match"
        tags = Tag.where("name LIKE?","#{word}%")
      elsif search == "backward_match"
        tags = Tag.where("name LIKE?","%#{word}")
      elsif search == "partial_match"
        tags = Tag.where("name LIKE?","%#{word}%")
      else
        tags = Tag.all
      end
      self.includes(:post_tags).where(post_tags: {tag_id: tags})
    else
      self
    end
  end

  def join?(user)
      participants.where(user_id: user.id).exists?
  end
end
