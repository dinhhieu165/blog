class Like < ApplicationRecord
  belongs_to :post, optional: true
  belongs_to :user

  scope :liked , -> (user_id, post_id){where("user_id = ? AND post_id = ?", user_id, post_id )}
end
