class ApplicationController < ActionController::API
  include ActionController::Cookies

  def login!(user)
    session[:user_id] = user.id
  end

  def current_user
    curernt_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
