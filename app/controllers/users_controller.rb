class UsersController <  ApplicationController

  def index
    @users = User.find(:all)
  end

  def destroy
    if params["id"]
       @child = User.find_by_id(params["id"]).destroy
    end

  end

  def create
    @user = User.new(params[:user].slice(:first_name, :last_name, :user_name, :email))

    if params[:roles]
      params[:roles].split(',').each do |role_input|
        if (@role =  Role.find_by_name(role_input) ) != nil
          @user.roles << @role
        else
          @new_role = Role.create!(name: role_input)
          @user.roles <<  @new_role
        end
      end
    end

    if @user.valid?
      @user.save!
    else
      response.status = 400
    end

  end

end
