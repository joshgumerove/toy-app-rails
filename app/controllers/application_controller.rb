# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper # NOTE: this syntax to include a module
  # note how refactored and put methods in sessions_helper
  def logged_in_user
    return if logged_in?

    store_location # NOTE: that this method is defined inside of a helper
    redirect_to login_url, notice: 'Please Log in'
  end
end

# note why we moved this method in here (available to other controllers then)