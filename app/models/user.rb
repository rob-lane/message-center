class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, presence: true,
            format: /[A-Za-z\d._%+-]+@[A-Za-z\d.-]+\.[A-Za-z]{2,4}/

  has_many :messages
end
