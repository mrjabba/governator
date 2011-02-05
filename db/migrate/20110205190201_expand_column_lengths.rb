class ExpandColumnLengths < ActiveRecord::Migration
  def self.up
    change_column(:resources, :name, :string, :limit => 2000)
  end

  def self.down
    change_column(:resources, :name, :string, :limit => 255)
  end
end
