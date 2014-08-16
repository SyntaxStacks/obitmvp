class CreateObits < ActiveRecord::Migration
  def change
    create_table :obits do |t|
      t.string :name
      t.string :img_link
      t.text :obituary
      t.integer :user_id

      t.timestamps
    end
  end
end
