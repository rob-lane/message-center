class Message < ActiveRecord::Base
  has_and_belongs_to_many :recipients, class_name: 'Contact',
                          join_table: :messages_contacts
  validates_presence_of :body
  validates_presence_of :recipients
  validates_associated :recipients


end
