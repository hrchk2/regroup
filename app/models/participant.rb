class Participant < ApplicationRecord

  belongs_to :user
  belongs_to :post

  enum approval_status: { "参加申請前": 0, "参加申請中": 1, "参加中": 2, "キャンセル待ち": 3 }

end
