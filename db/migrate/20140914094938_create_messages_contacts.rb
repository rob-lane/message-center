class CreateMessagesContacts < ActiveRecord::Migration
  def change
    create_table :messages_contacts do |t|
      t.integer :message_id
      t.integer :contact_id
    end
  end
end
