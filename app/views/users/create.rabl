object @user
attributes :id, :first_name, :last_name, :user_name, :email

node(:roles){ |user|
  user.roles.map(&:name).join(",")
}


