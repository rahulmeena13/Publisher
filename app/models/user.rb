class User < ActiveRecord::Base
  has_and_belongs_to_many :roles, :uniq => true
  has_many :articles, :inverse_of => :user
  
  after_save :update_roles
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  validates_presence_of :username
  validates_uniqueness_of :username
  
  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end
  
  def update_roles
    if self.roles.empty?
      user_role = Role.find_by_name('Reporter')
      self.roles << user_role  
    end
  end
end
