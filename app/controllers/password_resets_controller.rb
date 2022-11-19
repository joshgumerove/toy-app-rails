# frozen_string_literal: true

class PasswordResetsController < ApplicationController
  before_action :get_user, only: %i[edit update]
  before_action :valid_user, only: %i[edit update]
  before_action :check_expiration, only: %i[edit update]

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      redirect_to root_url, notice: 'password sent with password reset instructions'
    else
      flash[:notice] = 'Email address not found'
      render 'new'
    end
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "can't be empty")
      render 'edit'
    elsif @user.update(user_params)
      log_in @user
      redirect_to @user, notice: 'Password has been reset'
    else
      render 'edit'
    end
  end

  def new; end

  def edit; end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation) # tells what we are allowed to change
  end

  def get_user
    @user = User.find_by(email: params[:email])
  end

  def valid_user
    unless @user&.activated? &&
           @user&.authenticated?(:reset, params[:id])
      redirect_to root_url
    end
  end

  def check_expiration
    return unless @user.password_reset_expired?

    redirect_to new_password_reset_url, notice: 'password reset has expired'
  end
end

# rails g controller PasswordResets new edit --no-test-framework
# note how modeling as a resource although no active record model associated with this
# created separate topic branch
