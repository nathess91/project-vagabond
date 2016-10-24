class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.confirm(user_params)
    if @user
      login(@user)
      redirect_to user_path
    else
      flash[:error] = "Wrong username or password."
      redirect_to login_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end