class RenameAdressColumnToTweets < ActiveRecord::Migration[5.0]
  def change
    rename_column :tweets, :adress, :address
  end
end
