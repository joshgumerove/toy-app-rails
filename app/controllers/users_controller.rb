class UsersController < ApplicationController

  def index 
      @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
  @user = User.new(user_params)
    if @user.save
      # Handle a successful save.
      # redirect 'show'
      log_in @user #available here because defined it in the sessions helper which then included in the application controller
      redirect_to @user, notice: "Welcome to the Sample App!" #this will redirect to the user show page
      # http://localhost:3000/users/16
      #note the RESTful URL above
    else
      render 'new'
    end
  end
  
private
  def user_params
    debug
    params.require(:user).permit(:name, :email, :password,
      :password_confirmation)
  end
  # if successful we want to redirect to the show page
end