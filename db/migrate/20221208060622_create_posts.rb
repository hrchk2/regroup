class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.integer :capacity,null: false, default: 0
      t.integer:status,null: false, default: 0
      t.boolean :is_free, null: false, default: true
      t.boolean :is_stop, null: false, default: false

      t.timestamps
    end
  end
end
