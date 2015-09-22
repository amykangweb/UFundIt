class Deal < ActiveRecord::Base
  has_many :commitments
  belongs_to :owner, class_name: "User"
  has_many :users, through: :commitments
  validates :title, presence: true
  validates :description, presence: true
  validates :goal, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validates :start, presence: true
  validates :end, presence: true
end
