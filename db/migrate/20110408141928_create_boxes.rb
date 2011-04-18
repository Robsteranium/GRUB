class CreateBoxes < ActiveRecord::Migration
  def self.up
    create_table :boxes do |t|
      t.string :name
      t.string :description
      t.float :price
      t.string   "picture_file_name"
      t.string   "picture_content_type"
      t.integer  "picture_file_size"
      t.datetime "picture_updated_at"
      t.timestamps
    end
  end

  def self.down
    drop_table :boxes
  end
end
