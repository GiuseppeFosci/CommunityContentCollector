class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :google_create
  def new
  end

  def google_create
    user=User.find_by(email: google_params[:session][:email])
    if user
      forwarding_url = session[:forwarding_url] 
      reset_session
      google_params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      log_in user
      redirect_to forwarding_url || user
    else 
      flash[:warning] = "Utente non registrato, per favore registrati!"
      render "new", status: :unprocessable_entity
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        forwarding_url = session[:forwarding_url]
        reset_session
        params[:session][:remember_me] == "1" ? remember(user) :forget(user)
        log_in user
        redirect_to forwarding_url || user
      else
        message = "Account non attivato "
        message +="Controlla la tua email per il link di attivazione"
        flash[:warning] = message
        redirect_to root_url
      end
  else
    flash.now[:danger] = 'Combinazione email/password errata'
    render 'new', status: :unprocessable_entity
    end
  end
  
    def destroy
      log_out if logged_in?
      redirect_to root_url, status: :see_other
    end

  private
    def google_params
      pay =(Google::Auth::IDTokens.verify_oidc params[:credential], aud: "676271951973-1nhi134ag2edhefulklfqinnbkbajshc.apps.googleusercontent.com")
      payload=pay.values
      ret = ActionController::Parameters.new({"session": {"email": payload[5], "remember_me": "1"}, "commit": "Log in"})
    end 

  end
