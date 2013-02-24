class RegistrationsController <  ApplicationController

  def create
    @user = User.new(params[:registration].slice(:first_name, :last_name, :user_name, :email))
    if @user.valid?
      @user.save!
    else
      response.status = 400
    end

  end

  def login
    @user = User.find_by_email(params[:user][:email])

    if @user
      unless @user.valid_user_name?(params[:user][:user_name])
        render :json => {:errors => ["wrong credentials"]}, :status => 401
      end
    else
      render :json => {:errors => ["wrong credentials"]}, :status => 401
    end

  end

end
