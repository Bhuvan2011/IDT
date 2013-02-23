object @user
attributes :id, :name

node(:admin){ |user|
  user.admin?
}
