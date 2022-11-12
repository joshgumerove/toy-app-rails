class ApplicationController < ActionController::Base
  include SessionsHelper # NOTE: this syntax to include a module
  # note how refactored and put methods in sessions_helper
end
