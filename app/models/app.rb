class App < ActiveRecord::Base
  attr_accessible :name, :appgroup_id
  validates_lengths_from_database

  belongs_to :appgroup
  has_many :resources
  has_many :roles
  has_many :policies

  #remove the unique constraint for this i a bit..
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
