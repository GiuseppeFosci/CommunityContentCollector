class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  skip_before_action :verify_authenticity_token, only: :google_create

  # GET /users 
  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  # GET /users/[:id]
  def show
    @user = User.find(params[:id])
    redirect_to root_url and return unless @user.activated?
    @posts = @user.posts.paginate(page: params[:page])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/[:id]/edit
  def edit
    @user = User.find(params[:id])
  end

  def google_create
    @user = User.new(google_params)
    puts google_params[:password]
    if @user.save
      redirect_to edit_account_activation_url(@user.activation_token, email: @user.email)
      puts "Utente valido"
    else
      if @user.valid?
        flash[:warning] = "Email già registrata, procedi al login"
        render "/sessions/new", status: :unprocessable_entity
      else
        render "new", status: :unprocessable_entity
      end
    end
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Controlla la tua email per attivare l'account"
      redirect_to root_url
    else
      render 'new', status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profilo aggiornato"
      redirect_to @user
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Utente eliminato correttamente"
    redirect_to users_url, status: :see_other
  end
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow', status: :unprocessable_entity
  end
  
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow', status: :unprocessable_entity
  end

  #Search user
  def search_user
    @users = User.where("name LIKE ? OR surname LIKE ?", params[:name], params[:surname]).paginate(page: params[:page]) 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation)
    end
    
    def google_params
      pay =(Google::Auth::IDTokens.verify_oidc params[:credential], aud: "676271951973-1nhi134ag2edhefulklfqinnbkbajshc.apps.googleusercontent.com")
      payload=pay.values
      pass = BCrypt::Password.create(payload[5])
      ret = ActionController::Parameters.new({"user": {"name": payload[10], "surname": payload[11], "email": payload[5], "password": pass, "password_confirmation": ""}})
      ret.require(:user).permit(:name, :surname, :email, :password) #, :password_confirmation)
    end 
    
    # Confirms the correct user.    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url, status: :see_other) unless current_user?(@user)
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url, status: :see_other) unless current_user.admin?
    end
end
