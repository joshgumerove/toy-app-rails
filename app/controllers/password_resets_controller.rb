class PasswordResetsController < ApplicationController
  
  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user 
      @user.create_reset_digest
      @user.send_password_reset_email
      redirect_to root_url, notice: "password sent with password reset instructions"
    else
      flash[:notice] = "Email address not found"
      render 'new'
    end
  end

  def new
  end

  def edit
  end

end

# rails g controller PasswordResets new edit --no-test-framework
# note how modeling as a resource although no active record model associated with this 
# created separate topic branch