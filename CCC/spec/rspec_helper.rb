module Rspec_helper
  
  def login(user)
    user = User.where(:login => user.to_s).first if user.is_a?(Symbol)
    #post login_path, params: { session: { email: user.email, password: "password", remember_me: "1"} }
    request.session[:user] = user.id
  end
  
  # Returns true if a test user is logged in.
  def is_logged_in?
    !session[:user_id].nil?
  end

  # Log in as a particular user.
  def log_in_as(user)
    session[:user_id] = user.id
  end

  # Log in as a particular user.
  def log_in_as(user, password: 'password', remember_me: '1') post login_path, params: { session: { email: user.email, password: password, remember_me: remember_me} }
  end
end
RSpec.configure do |config|
  config.include Rspec_helper, :type => :request
end
