class Contact < ActiveRecord::Base
  validates :email, presence: true,
            format: /[\w.%+-]+@[A-Za-z\d.-]+\.[A-Za-z]{2,4}/,
            uniqueness: true
  has_and_belongs_to_many :messages
end
