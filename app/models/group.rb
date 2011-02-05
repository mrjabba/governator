class Group < ActiveRecord::Base
  attr_accessible :name
  validates_lengths_from_database

#  has_and_belongs_to_many :users
  has_many :memberships
  has_many :users, :through => :memberships

    validates :name, :presence => true

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

end
