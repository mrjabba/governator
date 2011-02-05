class User < ActiveRecord::Base
  attr_accessible :username, :first_name, :last_name
  validates_lengths_from_database

#todo --> read implement
# http://codecolossus.com/2011/01/01/why-you-should-always-validate-db-maximum-lengths-and-how-to-do-so-easily/

  has_many :memberships
  has_many :groups, :through => :memberships

  scope :not_in_group, lambda { |group|  
      join_clause = User.send(:sanitize_sql_array, 
        ["LEFT OUTER JOIN memberships ON memberships.user_id = users.id WHERE memberships.group_id <> ? or memberships.group_id is null", group ])  
        User.select("distinct(users.id), users.*").joins(join_clause) 
  }
 
    validates :username, :presence => true,
                  :length   => { :maximum => 200 }


  def self.search(search)
    if search
      where('username LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
  
end
