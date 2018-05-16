class RenameBodyColumnToTweets < ActiveRecord::Migration[5.0]
  def change
    rename_column :tweets, :body, :adress
  end
end
