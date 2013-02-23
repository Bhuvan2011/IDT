class RegistrationsController <  ApplicationController

  def create
    @user = User.new(params[:registration].slice(:first_name, :last_name, :user_name, :email, :password, :password_confirmation))
    if @user.valid?
      @user.save!
    else
      response.status = 400
    end

  end

  def login
    @user = User.find_by_email(params[:user][:email])

   if !(@user )#&& @user.valid_password?(params[:user][:password]))
      render :json => {:errors => ["wrong credentials"]}, :status => 401
   end

  end

end
