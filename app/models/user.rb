class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :user_name

  has_many :user_roles, inverse_of: :user, dependent: :destroy
  has_many :roles, through: :user_roles

  validates_presence_of :last_name, :first_name, :email, :user_name
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  validates_length_of :first_name, :maximum => 50
  validates_length_of :last_name, :maximum => 50
  validates_length_of :user_name, :maximum => 50
  validates_length_of :email, :maximum => 200
  validates_uniqueness_of :email

  # Properties

  def admin?
    has_role?(:admin)
  end


  # Methods:

  def has_role?(role_name)
    roles.any? { |role| role.name == role_name.to_s }
  end

  def valid_user_name?(user_name)
    self.user_name == user_name
  end

  def add_roles(roles)
     roles.split(',').each do |role_input|
       if (@role =  Role.find_by_name(role_input) ) != nil
         self.roles << @role if self.has_role?(@role)
       else
         @new_role = Role.create!(name: role_input)
         self.roles <<  @new_role
       end
     end
  end


end
