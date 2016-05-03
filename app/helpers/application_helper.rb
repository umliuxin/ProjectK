module ApplicationHelper
  def log_in(user)
    session[:username] = user.name
    user.remember
    cookies.permanent.signed[:username] = user.name
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
    # ap 'running current_user'
    if (user_name = session[:username])
      @current_user ||= User.find_by(name: session[:username])
    elsif (user_name = cookies.signed[:username])
      user = User.find_by(name: user_name)
      if user && user.authtoken?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:username)
    cookies.delete(:username)
    cookies.delete(:remember_token)
    @username=nil
  end
end
