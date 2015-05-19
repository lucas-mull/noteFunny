class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  def current_user
  	@_current_user ||= session[:current_user_id] && Utilisateur.find(session[:current_user_id])
  end

  def isConnected?
  	session[:current_user_id].present?
  end

  protect_from_forgery with: :exception
end
