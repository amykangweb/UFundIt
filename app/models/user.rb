class User < ActiveRecord::Base
  has_many :commitments
  has_many :deals, through: :commitments
  has_many :comments, dependent: :destroy
  has_many :owned_deals, class_name: "Deal", foreign_key: 'owner_id'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def deal_owner?(deal)
    deal.owner == self
  end
end

class NullUser
  def deal_owner?(deal)
    false
  end
end
