class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.float :lng  
      t.float :lat
      t.string :name
      t.string :postcode      
      t.string :street
      t.integer :user_id 
      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
