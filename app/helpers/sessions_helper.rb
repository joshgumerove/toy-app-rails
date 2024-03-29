# frozen_string_literal: true

module SessionsHelper
  def log_in(user)
    puts 'log_in method just ran!'
    session[:user_id] = user.id
  end
  # NOTE: that session is a method defined by rails
  # note how methods defined in here are available to all other controllers
  # note how we can view cookies in our browser by going to the application in browser tools and look at storage

  # Returns the user corresponding to the remember token cookie.
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.encrypted[:user_id])
      user = User.find_by(id: user_id)
      if user&.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  # NOTE: how we assigned a user to based on the session hash within the rails console

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  def logged_in?
    !current_user.nil? # if current_user is nil they are not logged_in
  end

  def is_logged_in?
    !session[:user_id].nil?
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user) # now can log in and out
    puts 'hello world'
    session.delete(:user_id) # NOTE: the delete method built into ruby available on hashes
    @current_user = nil
  end

  def remember(user)
    user.remember
    cookies.permanent.encrypted[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
end

# NOTE: how this is automatically generated when we create the sessions controller
