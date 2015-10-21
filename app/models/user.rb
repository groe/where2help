class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable

  # start @informatom 20151016
  #:confirmable, :omniauthable
  # end @informatom 20151016

  include DeviseTokenAuth::Concerns::User
  include AdminConfirmable

  # associations
  has_many :volunteerings
  has_many :needs

  # validations
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :phone, presence: true

  # callbacks
  after_create :first_user_gets_admin

  # instance methods
  def role
    case
    when admin?
      :admin
    when ngo_admin?
      :ngo
    else
      :volunteer      
    end
  end

  private
    def first_user_gets_admin
      if User.all.count == 1
        self.update(admin: true)
      end
    end
end
