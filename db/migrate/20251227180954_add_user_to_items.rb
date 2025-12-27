class AddUserToItems < ActiveRecord::Migration[8.0]
  def change
    add_reference :items, :user, foreign_key: true
  end
end
