class AddLatitudeAndLongitudeToTweet < ActiveRecord::Migration[5.0]
  def change
    add_column :tweets, :latitude, :float
    add_column :tweets, :longitude, :float
  end
end
