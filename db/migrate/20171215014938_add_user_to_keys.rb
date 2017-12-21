class AddUserToKeys < ActiveRecord::Migration[5.1]
  def change
    add_reference :keys, :user, foreign_key: true, index: true
  end
end
