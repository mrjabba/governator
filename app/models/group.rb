class Group < ActiveRecord::Base
  attr_accessible :name, :appgroup_id
  validates_lengths_from_database

  has_many :memberships
  has_many :users, :through => :memberships
  belongs_to :appgroup
  has_many :entities, :as => :entityable

    validates :name, :presence => true

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

end
