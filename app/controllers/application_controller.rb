class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :admin?
  
  protected
  
  def authenticate_user
  	if session[:user_id]
  		@current_user = User.find(session[:user_id])
  		return true
  	else
  		redirect_to('/login')
  		return false
  	end
  end
  
  def save_login_state
    if session[:user_id] and session[:user_id] != 1
      redirect_to('/home')
      return false
    else
      return true
    end
  end

  def save_login_state2
    if session[:user_id]
      redirect_to('/home')
      return false
    else
      return true
    end
  end
  
  def admin?
    return session[:user_id]==1
  end
  
  def authorize
    unless admin?
      flash[:notice] = "Unauthorized Access"
      redirect_to('/home')
      false
    end
  end
end