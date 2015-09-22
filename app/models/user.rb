class User < ActiveRecord::Base
  has_many :commitments
  has_many :deals, through: :commitments
  has_many :committed_deals, through: :commitments, class_name: "Deal"
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def deal_owner?(deal)
    deal.owner == self
  end
end

class NullUser
  def owner?
    false
  end
end
