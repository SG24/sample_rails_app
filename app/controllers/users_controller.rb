class UsersController < ApplicationController
  def show 
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    # Successful signup
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user  # alternative: redirect_to user_url(@user)
    # Failed signup
    else
      render "new"
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
