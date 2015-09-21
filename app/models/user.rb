class User < ActiveRecord::Base
  has_many :commitments
  has_many :deals
  has_many :commited_deals, through: :commitments, class_name: "Deal"
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
