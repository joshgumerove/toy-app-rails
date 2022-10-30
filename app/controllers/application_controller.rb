class ApplicationController < ActionController::Base
        include SessionsHelper #note this syntax to include a module

        def log_in(user)
            puts "log_in method just ran!"
            session[:user_id] = user.id
        end
        #note that session is a method defined by rails
        #note how methods defined in here are available to all other controllers 
        #note how we can view cookies in our browser by going to the application in browser tools and look at storage

        def current_user
            if session[:user_id]
                puts "current_user method just ran"
                @current_user || = User.find_by(id: session[:user_id])
            end
        end
end
