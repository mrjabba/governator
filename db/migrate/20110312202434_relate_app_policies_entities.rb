class RelateAppPoliciesEntities < ActiveRecord::Migration
  def self.up  
  
    create_table :policies do |t|
      t.integer :app_id
      t.timestamps
    end
    create_table :entities do |t|
      t.integer :policy_id
      t.boolean :permit, :default => false
      t.integer :entityable_id
      t.string :entityable_type
      t.timestamps
    end  
  end

  def self.down
    drop_table :policies
    drop_table :entities
  end
end
