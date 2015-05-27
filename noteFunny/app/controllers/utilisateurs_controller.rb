require 'securerandom'
require 'bcrypt'

class UtilisateursController < ApplicationController
  before_action :set_utilisateur, only: [:show, :edit, :update, :destroy]

  # GET /utilisateurs
  # GET /utilisateurs.json
  def index
    if isConnected?
      @utilisateur = current_user
    end
  end

  # GET /utilisateurs/1
  # GET /utilisateurs/1.json
  def show
  end

  # GET /utilisateurs/new
  def new
    @utilisateur = Utilisateur.new
    if (params[:type] == 'Etudiant')
      @password = SecureRandom.base64(10)  
    end
    @utilisateur.type = params[:type]  
  end



  # GET /utilisateurs/1/edit
  def edit
  end

  def list
    if isConnected? && current_user.type == 'Admin'
      @utilisateurs = Utilisateur.all.sort_by{|user| [user.type, user.nom]}
      @utilisateur = current_user
    else
      redirect_to root_path
    end
  end

  # POST /utilisateurs
  # POST /utilisateurs.json
  def create
    @password = params[:utilisateur][:password]
    if params[:utilisateur][:type]
      @utilisateur = Enseignant.new(utilisateur_params)
    else
      @utilisateur = Etudiant.new(utilisateur_params)
    end
    @utilisateur.etat = 'pending'
    respond_to do |format|
      if @utilisateur.save
        if @utilisateur.type == 'Enseignant'
          format.html { redirect_to root_path, notice: 'Votre compte a été créé. Toutefois, un admin doit le valider. Vous recevrez un mail une fois cette opération effectuée' }
          format.json { render :show, status: :created, location: root_path }
        else
          format.html { redirect_to sendConfirmEmail_path(:matiere_id => current_matiere.id, :etudiant_id => @utilisateur.id, :temp_password => @password) }
          format.json { render :show, status: :created, location: matieres_path }
        end
      else
        format.html { render :new }
        format.json { render json: @utilisateur.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /utilisateurs/1
  # PATCH/PUT /utilisateurs/1.json
  def update
    respond_to do |format|
      if @utilisateur.update(utilisateur_params)
        format.html { redirect_to @utilisateur, notice: 'Utilisateur was successfully updated.' }
        format.json { render :show, status: :ok, location: @utilisateur }
      else
        format.html { render :edit }
        format.json { render json: @utilisateur.errors, status: :unprocessable_entity }
      end
    end
  end

  def login
    if (user = Utilisateur.find_by(email: params[:email])) != nil
      if user.authenticate(params[:password])
        if user.etat != 'pending'
          session[:current_user_id] = user.id
          flash[:alert] = 'Vous êtes connecté.'
          redirect_to root_path
        else
          flash[:alert] = 'Votre compte n\'a pas encore été activé'
          redirect_to root_path
        end
      else
        flash[:alert] = 'Mauvais identifiant ou mot de passe'
        redirect_to root_path
      end
    else
      flash[:alert] = 'Mauvais identifiant ou mot de passe'
      redirect_to root_path
    end
  end

  def logout
    session.destroy
    respond_to do |format|
      format.html{ redirect_to "/", alert: 'Vous vous êtes déconnectés' }
    end
  end

  def change_password
  end

  def submit_password_change
    @utilisateur = current_user
    if @utilisateur.authenticate(params[:old_password])
      @utilisateur.update(:password => params[:new_password], :password_confirmation => params[:new_password_confirmation])
      respond_to do |format|
        format.html{ redirect_to root_path, notice: 'Mot de passe changé avec succès'}
      end
    else
      respond_to do |format|
        format.html{ redirect_to root_path, notice: 'Mot de passe incorrect'}
      end
    end
  end

  def confirm
    @utilisateurs = Utilisateur.all
    @utilisateur = Utilisateur.find(params[:id])
    @utilisateur.update_attribute('etat', 'validé')
    respond_to do |format|
      format.html{ redirect_to root_path, notice: 'Vous pouvez désormais vous connecter au site grâce à votre email'}
    end
  end

  def confirm_admin
    @utilisateurs = Utilisateur.all
    @utilisateur = Utilisateur.find(params[:id])
    respond_to do |format|
      if @utilisateur.update_attribute('etat', 'validé')
        format.html{ redirect_to utilisateurs_list_path, notice: 'Utilisateur validé'}
      else
        format.html { render :list }
      end
    end
  end

  # DELETE /utilisateurs/1
  # DELETE /utilisateurs/1.json
  def destroy
    if @utilisateur.type == 'Enseignant'
      @utilisateur.matieres.each do |m|
        m.destroy
      end
    elsif @utilisateur.type == 'Etudiant'
      @utilisateur.appartenances.each do |a|
        a.destroy
      end
      @utilisateur.resultats.each do |res|
        res.destroy
      end
    else
      respond_to do |format|
        format.html { redirect_to utilisateurs_list_path, notice: 'Impossible de supprimer un compte admin' }
        format.json { head :no_content }
      end
    end
    @utilisateur.destroy
    respond_to do |format|
      format.html { redirect_to utilisateurs_list_path, notice: 'Utilisateur supprimé avec succès' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_utilisateur
      @utilisateur = Utilisateur.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def utilisateur_params
      allow = [:nom, :prenom, :email, :password, :password_confirmation, :type]
      params.require(:utilisateur).permit(allow)
    end
end
