class ApplicationController < ActionController::Base
    include SessionsHelper
    
    def hello
        render html: "hello, world!"
    end

    # Logs in the given user.
    def log_in(user)
        session[:user_id] = user.id
    end


end
