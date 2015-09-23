class Update < ActiveRecord::Base
  belongs_to :deal
  validates :content, presence: true
end
