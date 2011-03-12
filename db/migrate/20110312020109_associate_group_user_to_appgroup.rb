class AssociateGroupUserToAppgroup < ActiveRecord::Migration
  def self.up
    add_column :users, :appgroup_id, :integer
    add_column :groups, :appgroup_id, :integer
  end

  def self.down
    remove_column :users, :appgroup_id
    remove_column :groups, :appgroup_id
  end
end
