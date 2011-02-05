class Appgroup < ActiveRecord::Base
  attr_accessible :name
  validates_lengths_from_database

  has_many :apps
  
  validates :name, :presence => true

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end


end
