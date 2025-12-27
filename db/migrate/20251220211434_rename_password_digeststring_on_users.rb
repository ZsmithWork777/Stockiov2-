class RenamePasswordDigeststringOnUsers < ActiveRecord::Migration[8.0]
  def change
    rename_column :users, :password_digeststring, :password_digest
  end
end
