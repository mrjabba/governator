class App < ActiveRecord::Base
  attr_accessible :name, :appgroup_id
  validates_lengths_from_database

  belongs_to :appgroup
  has_many :resources
  has_many :roles
  has_many :policies

  validates :name, :presence => true

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end


end
