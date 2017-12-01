class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :content, presence: true
  default_scope -> { order(created_at: :desc) }

  delegate :name, to: :user, prefix: true
end
