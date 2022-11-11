class SessionsController < ApplicationController
  def create
    # puts params[:session][:email] note how we can access the value
    # puts "cool"
    user = User.find_by(email: params[:session][:email].downcase)
    # if user && user.authenticate(params[:session][:password]) #would return false for invalid password
      #do something here
      if user&.authenticate(params[:session][:password]) #note the "safe navigation" shorthand operator
      log_in user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      puts "this is right before redirect_back_or"
      redirect_back_or user #note this will redirect to the show page for this user
    else
    #note the user of a ternary in rails/ruby
    redirect_to '/login'
    flash.notice = 'invalid email/password combination'
    # note how this is different from the lecture because we are using rails 7
    end
  end

  def new
  end

  def destroy
    puts "now redirecting"
    log_out if logged_in?
    redirect_to root_url
    # redirect_to root_url
  end

  #note how we are only logging users out in the destroy action (unlike login)

end

#note that the sessions controller also follows RESTful architecture
#rails g controller Sessions new 
#note when we include an action a view is also generated

#note main differencce between this and users controller is that there is no sessions model
# @gumerove = @gumerove || "josh gumerove" notice this syntax available to use in rails
# will assign a value if the value is nil