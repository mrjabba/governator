class User < ActiveRecord::Base
  attr_accessible :username, :first_name, :last_name

#  has_and_belongs_to_many :groups
  has_many :memberships
  has_many :groups, :through => :memberships
 
    validates :username, :presence => true,
                  :length   => { :maximum => 255 }


  def self.search(search)
    if search
      where('username LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
  
end
