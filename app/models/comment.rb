class Comment < ActiveRecord::Base
  default_scope -> { order('created_at DESC') }
  belongs_to :deals
  belongs_to :user
  validates :body, presence: true
end
