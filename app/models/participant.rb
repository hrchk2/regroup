class Participant < ApplicationRecord
  
  belongs_to :user
  belongs_to :post
  
  enum approval_status: { "参加申請中": 0, "参加中": 1, "キャンセル待ち": 2 }
  
end
