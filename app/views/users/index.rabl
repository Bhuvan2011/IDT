collection @users, :object_root => false

attributes :id, :email, :first_name, :last_name, :user_name

node(:roles){ |user|
  user.roles.map(&:name).join(",")
}

