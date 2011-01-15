class AddRelationRolesToApps < ActiveRecord::Migration
  def self.up
    add_column :roles, :app_id, :integer
    add_index :roles, :app_id
  end

  def self.down
    remove_column :roles, :app_id
    remove_index :roles, :app_id
  end
end
