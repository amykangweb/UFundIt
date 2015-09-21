class Deal < ActiveRecord::Base
  validates :title, presence: true
  validates :description, presence: true
  validates :goal, presence: true
  validates :amount, presence: true #want amount to be > 0
  validates :start, presence: true
  validates :end, presence: true
end
