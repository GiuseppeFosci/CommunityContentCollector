class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  # GET /users or /users.json
  def index
    @users = User.paginate(page: params[:page])
  end

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(params[:id])
    
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation)
    end
    
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Effettua l'accesso per modificare"
        redirect_to login_url, status: :see_other
      end
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
