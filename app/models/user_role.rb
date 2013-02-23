class UserRole < ActiveRecord::Base
  # Fields:
  attr_accessible :user, :role

  # Associations:
  belongs_to :user, inverse_of: :user_roles
  belongs_to :role

  # Validations:
  validates_presence_of :user
  validates_presence_of :role
end
