class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index] #will run logged_in_user before edit and update action
                                                     #note how the above actions now require a logged in user
  before_action :correct_user, only: [:edit, :update] #to make sure only user can edit their own profile
 #note how could also put in a single before_action

  def index 
      @users = User.paginate(page: params[:page])
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

def edit
  @user = User.find(params[:id])
end

def update
  puts "update should be here"
  @user = User.find(params[:id])
  if @user.update(user_params)
  redirect_to @user, notice: "Profile updated"
  else
    render 'edit'
  end
end
  
private
  def user_params
    params.require(:user).permit(:name, :email, :password,
      :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      store_location #note that this method is defined inside of a helper
      redirect_to login_url, notice: "Please Log in"
    end
  end

  def current_user?(user)
    user && user == current_user #note the && -- helps catch edge case where user is nil (which is falsy in Ruby)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_url unless current_user?(@user) #will redirect to a different page if trying to edit 
  end
  # if successful we want to redirect to the show page
end