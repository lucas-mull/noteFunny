class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  helper_method :current_user

  def current_user
  	@_current_user ||= session[:current_user_id] && Utilisateur.find(session[:current_user_id])
  end

  def current_matiere
  	@_current_matiere ||= session[:current_matiere_id] && Matiere.find(session[:current_matiere_id])
  end

  def current_epreuve
    @_current_epreuve ||= session[:current_epreuve_id] && Epreuve.find(session[:current_epreuve_id])
  end

  def isConnected?
  	session[:current_user_id].present?
  end

  protect_from_forgery with: :exception
end
