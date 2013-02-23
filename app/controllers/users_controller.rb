class UsersController <  ApplicationController

  def index
    @users = User.find(:all)
  end

  def destroy
    if params["id"]
       @child = User.find_by_id(params["id"]).destroy
    end

  end

end
