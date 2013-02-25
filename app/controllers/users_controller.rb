class UsersController <  ApplicationController

  def index
    @users = User.find(:all)
  end

   def update
     @user = User.find(params[:id])

     attributes = { first_name: params[:first_name],
                    last_name: params[:last_name],
                    user_name: params[:user_name],
                    email: params[:email]
                  }

      if @user.update_attributes(attributes)
        if params[:roles]
           @user.add_roles(params[:roles])
        end
        @user.save!
      else
        response.status = 400
      end
  end # update

  def destroy
    if params["id"]
       @child = User.find_by_id(params["id"]).destroy
       response.status = 200
    else
      response.status = 400
    end
  end

  def create
    @user = User.new(params[:user].slice(:first_name, :last_name, :user_name, :email))

    if params[:roles]
      @user.add_roles(params[:roles])
    end

    if @user.valid?
      @user.save!
    else
      response.status = 400
    end

  end

end
