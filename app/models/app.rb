class App < ActiveRecord::Base
  attr_accessible :name, :appgroup_id

  belongs_to :appgroup
  has_many :resources
  has_many :roles
  
    validates :name, :presence => true,
                  :length   => { :maximum => 255 }


  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end


end
