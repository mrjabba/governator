class CreateAppgroups < ActiveRecord::Migration
  def self.up
    create_table :appgroups do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :appgroups
  end
end
