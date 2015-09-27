class User < ActiveRecord::Base
  include Gravtastic
  gravtastic
  has_many :commitments
  has_many :deals, through: :commitments
  has_many :comments, dependent: :destroy
  has_many :owned_deals, class_name: "Deal", foreign_key: 'owner_id'
  validates :name, presence: true, uniqueness: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable


  def deal_owner?(deal)
    deal.owner == self
  end

  def update_owner?(update)
    update.deal.owner == self
  end

  def admin?
    self.admin
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.first_name
      user.email = auth.info.email
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
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
