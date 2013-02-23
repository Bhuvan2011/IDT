class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :user_name

  has_many :user_roles, inverse_of: :user, dependent: :destroy
  has_many :roles, through: :user_roles

  # Properties

  def admin?
    has_role?(:admin)
  end


  # Methods:

  def has_role?(role_name)
    roles.any? { |role| role.name == role_name.to_s }
  end


end
