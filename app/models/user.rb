class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :following, :class_name => 'Followings', :foreign_key => 'follower_id'  

  has_many :posts   

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,:first_name,:last_name
  # attr_accessible :title, :body

  ThinkingSphinx::Index.define :user, :with => :active_record do
	  indexes email, :sortable => true
	  indexes first_name
	  indexes last_name
    indexes posts(:content), :as => :posts
  end

  def following
    Followership.where(:follower_id=>self.id).not_blocked
  end

end
