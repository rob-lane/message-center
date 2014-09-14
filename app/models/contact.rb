class Contact < ActiveRecord::Base
  validates :email, presence: true,
            format: /[\w.%+-]+@[A-Za-z\d.-]+\.[A-Za-z]{2,4}/
  has_and_belongs_to_many :messages
end
