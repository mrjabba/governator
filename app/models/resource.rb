class Resource < ActiveRecord::Base
  attr_accessible :name, :app_id
  validates_lengths_from_database

  belongs_to :app
  has_many :entities, :as => :entityable
 
  validates :name, :presence => true

  delegate :name, :to => :app, :prefix => true 

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

end
