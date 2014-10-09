class UsersController < ApplicationController
  before_filter :save_login_state, :only => [:new, :create]
  before_filter :authorize, :except => [:new, :create, :show, :edit, :update, :destroy]
  before_filter :user_authorize, :only => [:show, :edit, :update, :destroy]
  before_filter :authenticate_user, :except => [:new, :create]
  before_action :set_image, only: [:show, :edit, :update, :destroy]
  
  # GET /users
  # GET /users.json
  def index
    @current_user = User.find(session[:user_id])
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/1/edit
  def edit
  end

  def new
  	@user = User.new
  end
  
  def create
  	@user = User.new(user_params)
  	if @user.save
  		flash[:notice] = "Sign Up Successful!"
      if admin?
        return redirect_to('/users')
      end
      return redirect_to('/login')
  	else
  		flash[:notice] = "Form is invalid"
  	end
  	render "new"
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    Score.where(:user_id => session[:user_id]).destroy_all
    @user.destroy
    if admin?
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      session[:user_id]=nil
      respond_to do |format|
        format.html {redirect_to "/login", notice: 'Account deleted successfully!' }
      end
    end
  end

  private
  def user_params
	 params.require(:user).permit(:name, :email, :username, :password, :password_confirmation)
  end

  def set_image
      @user = User.find(params[:id])
  end
  def user_authorize
    unless session[:user_id] == params[:id].to_i or admin?
      flash[:notice] = "Unauthorized Access"
      redirect_to('/home')
      false
    end
  end
end