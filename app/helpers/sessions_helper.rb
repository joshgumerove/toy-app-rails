module SessionsHelper
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
                @current_user ||= User.find_by(id: session[:user_id]) #note that must not have space ||=
            end
        end
        #note how we assigned a user to based on the session hash within the rails console

        def logged_in?
            !current_user.nil? # if current_user is nil they are not logged_in
        end

        def is_logged_in?
            !session[:user_id].nil?
        end
end

# note how this is automatically generated when we create the sessions controller
