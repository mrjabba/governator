class Resource < ActiveRecord::Base
  attr_accessible :name, :app_id
  validates_lengths_from_database

  belongs_to :app
  
  validates :name, :presence => true

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end


end
