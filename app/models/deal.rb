 class Deal < ActiveRecord::Base
  default_scope -> { order('created_at DESC') }
  has_many :commitments
  has_many :updates, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :owner, class_name: "User"
  has_many :users, through: :commitments
  validates :title, presence: true
  validates :description, presence: true
  validates :goal, numericality: {  greater_than: 0 }
  validates :amount, numericality: {  greater_than: 0 }
  validates :start, presence: true
  validates :end, presence: true

  # http://www.jorgecoca.com/buils-search-form-ruby-rails/
  def self.search(query)
    self.where('title LIKE ?', "%#{query}%").where(published: true).where(private: false)
  end

  def funded?
    self.users.count >= self.goal
  end

  def active? # published and not expired
    self.end > Time.now && self.published
  end

  def archived? # expired deals
    self.end < Time.now
  end
end
