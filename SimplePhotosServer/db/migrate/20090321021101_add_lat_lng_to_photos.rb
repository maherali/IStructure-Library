class AddLatLngToPhotos < ActiveRecord::Migration
  def self.up
    add_column :photos, :lat, :double,  :precision => 13, :scale => 10
    add_column :photos, :lng, :double,  :precision => 13, :scale => 10
  end

  def self.down
    remove_column :photos, :lat
    remove_column :photos, :lng
  end
end
