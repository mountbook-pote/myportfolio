class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :comment
      t.integer :user_id
      t.integer :met_object_id

      t.timestamps
    end
  end
end
