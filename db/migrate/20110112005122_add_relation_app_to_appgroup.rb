class AddRelationAppToAppgroup < ActiveRecord::Migration
  def self.up
    add_column :apps, :appgroup_id, :integer
    add_index :apps, :appgroup_id
  end

  def self.down
    remove_column :apps, :appgroup_id
    remove_index :apps, :appgroup_id
   end
end
