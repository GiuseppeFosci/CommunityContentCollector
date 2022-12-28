class ApplicationController < ActionController::Base
    include SessionsHelper
    
    def hello
        render html: "hello, world!"
    end

    # Logs in the given user.
    def log_in(user)
        session[:user_id] = user.id
    end

    private
    
    # Confirms a logged-in user.
    def logged_in_user
        unless logged_in?
            store_location
            flash[:danger] = "Perfavore accedi."
            redirect_to login_url, status: :see_other
        end
    end

end
