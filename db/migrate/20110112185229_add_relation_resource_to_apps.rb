class AddRelationResourceToApps < ActiveRecord::Migration
  def self.up
    add_column :resources, :app_id, :integer
    add_index :resources, :app_id
  end

  def self.down
    remove_column :resources, :app_id
    remove_index :resources, :app_id
  end
end
