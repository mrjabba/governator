class Appgroup < ActiveRecord::Base
  attr_accessible :name

  has_many :apps
  
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
