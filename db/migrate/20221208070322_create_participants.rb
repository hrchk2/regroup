class CreateParticipants < ActiveRecord::Migration[6.1]
  def change
    create_table :participants do |t|
      t.integer:user_id,null: false
      t.integer:post_id,null: false
      t.integer:approval_status,null: false,default: 

      t.timestamps
    end
  end
end
