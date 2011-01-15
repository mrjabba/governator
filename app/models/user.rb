class User < ActiveRecord::Base
  attr_accessible :username
  
    validates :username, :presence => true,
                  :length   => { :maximum => 255 }
  
end
