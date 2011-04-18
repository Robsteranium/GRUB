class CreateRolesAssign < ActiveRecord::Migration
  def self.up
    create_table "assignments", :force => true do |t|
      t.integer  "user_id"
      t.integer  "role_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  
    add_index "assignments", ["id"], :name => "index_assignments_on_id"
    add_index "assignments", ["role_id"], :name => "index_assignments_on_role_id"
    add_index "assignments", ["user_id"], :name => "index_assignments_on_user_id"
    
    create_table "roles", :force => true do |t|
      t.string   "name"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  
    add_index "roles", ["id"], :name => "index_roles_on_id"
    add_index "roles", ["name"], :name => "index_roles_on_name"

  end

  def self.down
    drop_table "assignments"
    drop_table "roles"
  end
end
