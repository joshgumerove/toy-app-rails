# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[edit update index] # will run logged_in_user before edit and update action
  # note how the above actions now require a logged in user
  before_action :correct_user, only: %i[edit update] # to make sure only user can edit their own profile
  # note how could also put in a single
  before_action :admin_user, only: :destroy

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_url, notice: 'user deleted'
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # Handle a successful save.
      # redirect 'show'
      @user.send_activation_email
      UserMailer.account_activation(@user).deliver_now # noe how email will appear in the logs
      redirect_to root_url, notice: 'Check your email to activate your account' # this will redirect to the user show page
      # http://localhost:3000/users/16
      # note the RESTful URL above
      # note we do not route explicitly to the UserMailer
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    puts 'update should be here'
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: 'Profile updated'
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation) # tells what we are allowed to change
  end

  def current_user?(user)
    user && user == current_user # NOTE: the && -- helps catch edge case where user is nil (which is falsy in Ruby)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_url unless current_user?(@user) # will redirect to a different page if trying to edit
  end
  # if successful we want to redirect to the show page

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end

# NOTE: the use of the send method in metaprogramming ==> a.send(:length)
