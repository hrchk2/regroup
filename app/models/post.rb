class Post < ApplicationRecord
  
  belongs_to :user
  
  enum status: { "公開": 0, "下書き": 1 }
  
end
