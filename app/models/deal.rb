 class Deal < ActiveRecord::Base
  default_scope -> { order('created_at DESC') }
  mount_uploader :image, ImageUploader
  has_many :commitments
  has_many :updates, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :owner, class_name: "User"
  has_many :users, through: :commitments
  validates :title, length: { in: 3..140 }
  validates :description, presence: true
  validates :goal, numericality: {  greater_than: 0 }
  validates :amount, numericality: {  greater_than: 0 }
  validates :end, presence: true
  validates :start, presence: true
  validate :date_validation
  validate :image_size

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
    self.end < Time.now && self.published
  end

  def published?
    self.published
  end

  def flagged?
    self.flag
  end

  private

  def date_validation
    if self[:end] < self[:start]
      errors[:end] << "End date must come after start date."
      return false
    else
      return true
    end
  end

  def image_size
    if image.size > 5.megabytes
      errors.add(:image, "should be less than 5MB")
    end
  end
end
