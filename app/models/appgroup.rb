class Appgroup < ActiveRecord::Base
  attr_accessible :name
  validates_lengths_from_database

  has_many :apps
  has_many :groups
  has_many :users
  
  validates :name, :presence => true
#  validates :name, :presence => true,
#                  :uniqueness => { :case_sensitive => false }

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end


end
