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
  end



  # GET /utilisateurs/1/edit
  def edit
  end

  # POST /utilisateurs
  # POST /utilisateurs.json
  def create
    @utilisateur = Utilisateur.new(utilisateur_params)
    @utilisateur.etat = 'pending'

    respond_to do |format|
      if @utilisateur.save
        format.html { redirect_to @utilisateur, notice: 'Votre compte a été créé. Toutefois, un admin doit le valider. Vous recevrez un mail une fois cette opération effectuée' }
        format.json { render :show, status: :created, location: @utilisateur }
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
    respond_to do |format|
      if (user = Utilisateur.find_by(email: params[:email])) != nil
        if user.password == params[:password]
          if user.etat != 'pending'
            session[:current_user_id] = user.id
            format.html{ redirect_to "/", notice: 'Vous êtes connecté.' }
          else
            format.html{ redirect_to "/", notice: 'Votre compte n\'a pas encore été activé' }
          end
        else
          format.html{ redirect_to "/", notice: 'Mauvais mot de passe' }
        end
      else
        format.html{ redirect_to "/", notice: 'Utilisateur inconnu' }
      end
    end
  end

  def logout
    session.delete(:current_user_id)
    respond_to do |format|
      format.html{ redirect_to "/", notice: 'Vous vous êtes déconnectés' }
    end
  end

  # DELETE /utilisateurs/1
  # DELETE /utilisateurs/1.json
  def destroy
    @utilisateur.destroy
    respond_to do |format|
      format.html { redirect_to utilisateurs_url, notice: 'Utilisateur was successfully destroyed.' }
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
      allow = [:nom, :prenom, :email, :password]
      params.require(:utilisateur).permit(allow)
    end
end
