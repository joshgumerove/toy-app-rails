class SessionsController < ApplicationController
  def create
    # puts params[:session][:email] note how we can access the value
    # puts "cool"
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password]) #would return false for invalid password
      #do something here
      puts "nailed it"
      redirect_to user #note this will redirect to the show page for this user
    else
      puts "wrong password"
    render 'new'
    end
  end

  def new
  end

  def destroy
  end

end

#note that the sessions controller also follows RESTful architecture
#rails g controller Sessions new 
#note when we include an action a view is also generated

#note main differencce between this and users controller is that there is no sessions model
