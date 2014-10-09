class SessionsController < ApplicationController
  before_filter :authenticate_user, :only => [:home, :profile, :setting, :playgame, :submit_score, :view_scores, :leaderboard, :return_name]
  before_filter :save_login_state2, :only => [:login, :login_attempt]

  def login
  end

  def login_attempt
  	authorized_user = User.authenticate(params[:username_or_email], params[:login_password])
  	if authorized_user
  		session[:user_id] = authorized_user.id
  		flash[:notice]="Welcome, you logged in as #{authorized_user.username}"
  		redirect_to('/home')
  	else
  		flash[:notice] = "Invalid Username or Password"
  		render "login"
  	end
  end

  def home
  end

  def profile
    return redirect_to("/users/"+session[:user_id].to_s)
  end

  def setting 
    begin
      @scores = Score.where(user_id: @current_user.id).order(created_at: :desc)
      print @scores
    rescue ActiveRecord::RecordNotFound
      @scores = nil
    end
  end

  def leaderboard
    begin
      @scores = Score.all.order(score: :desc).order(created_at: :asc).first(10)
    rescue ActiveRecord::RecordNotFound
      @scores = nil
    end
  end

  def playgame
    @imageHash = Array.new
    @images=Image.all
    @images.each do |image|
      @imageHash[image.id]=image.tag
    end
  end

  def submit_score
    @score = Score.new({:user_id=>params[:user_id].to_i, :score=>params[:finalscore].to_i})
    @score.save
  end

  def send_mail
    @send_to = params[:send_to]
    @user = User.find(session[:user_id]).name
    @score = Score.where(:user_id=>session[:user_id]).last.score
    InviteMailer.send_invites(@send_to, @user, @score).deliver
    flash[:notice] = "E-mail Sent!"
  end

  def logout
  	session[:user_id] = nil
  	redirect_to('/login')
  end
end
