class Deal < ActiveRecord::Base
  default_scope -> { order('created_at DESC') }
  has_many :commitments
  has_many :comments, dependent: :destroy
  belongs_to :owner, class_name: "User"
  has_many :users, through: :commitments
  validates :title, presence: true
  validates :description, presence: true
  validates :goal, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validates :start, presence: true
  validates :end, presence: true

  def funded?
    self.users.count >= self.goal
  end

  def active?
    self.end < Time.now && self.published
  end
end

