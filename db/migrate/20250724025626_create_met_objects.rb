class CreateMetObjects < ActiveRecord::Migration[6.1]
  def change
    create_table :met_objects do |t|
      t.integer :object_id
      t.string :department

      t.timestamps
    end
  end
end
