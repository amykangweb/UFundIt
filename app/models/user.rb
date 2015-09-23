class User < ActiveRecord::Base
  has_many :commitments
  has_many :deals, through: :commitments
  has_many :comments, dependent: :destroy
  has_many :owned_deals, class_name: "Deal", foreign_key: 'owner_id'
  validates :name, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, presence: true

  def deal_owner?(deal)
    deal.owner == self
  end

  def update_owner?(update)
    update.deal.owner == self
  end

  def admin?
    self.admin
  end
end

class NullUser
  def deal_owner?(deal)
    false
  end

  def update_owner?(update)
    false
  end

  def admin?
    false
  end
end
