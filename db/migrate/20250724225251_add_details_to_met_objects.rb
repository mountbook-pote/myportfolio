class AddDetailsToMetObjects < ActiveRecord::Migration[6.1]
  def change
    add_column :met_objects, :title, :string
    add_column :met_objects, :artist_display_name, :string
    add_column :met_objects, :object_date, :string
    add_column :met_objects, :primary_image_small, :string
    add_column :met_objects, :object_url, :string
  end
end
