class CreateLink < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.int, :message_id
      t.string :url
    end
  end
end
