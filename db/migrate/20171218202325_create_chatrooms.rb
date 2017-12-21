class CreateChatrooms < ActiveRecord::Migration[5.1]
  def change
    create_table :chatrooms do |t|
      t.string :topic
      t.string :slug, index: true, uniqueness: true
      t.timestamps
    end
  end
end
