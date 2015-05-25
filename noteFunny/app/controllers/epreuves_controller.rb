class EpreuvesController < ApplicationController
  before_action :set_epreuve, only: [:show, :edit, :update, :destroy]

  # GET /epreuves
  # GET /epreuves.json
  def index
    if isConnected?
      @utilisateur = current_user
      # session.delete([:current_matiere_id])
      if @utilisateur.type == 'Admin'
        @matieres = Matiere.all
      elsif @utilisateur.type == 'Enseignant'
        @matieres = @utilisateur.matieres
      else
        @matieres = Appartenance.getMatieresFromEtu(@utilisateur.id)
      end
    else
      redirect_to root_path
    end
  end

  def index_by
    if isConnected?
      @matiere = Matiere.find(params[:matiere_id])
    else
      redirect_to root_path
    end
  end

  # GET /epreuves/1
  # GET /epreuves/1.json
  def show
  end

  # GET /epreuves/new
  def new
    @epreuve = Epreuve.new
    @matiere = current_matiere
    @epreuve.matiere_id = @matiere.id
  end

  def set_matiere
    session[:current_matiere_id] = params[:matiere_id]
    redirect_to new_epreuve_path
  end

  # GET /epreuves/1/edit
  def edit
  end

  # POST /epreuves
  # POST /epreuves.json
  def create
    @epreuve = Epreuve.new(epreuve_params)

    respond_to do |format|
      if @epreuve.save
        session[:current_epreuve_id] = @epreuve.id
        format.html { redirect_to epreuves_path }
        format.json { render :show, status: :created, location: @epreuve }
      else
        format.html { render :new }
        format.json { render json: @epreuve.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /epreuves/1
  # PATCH/PUT /epreuves/1.json
  def update
    respond_to do |format|
      if @epreuve.update(epreuve_params)
        format.html { redirect_to epreuves_path, alert: 'Vos modifications ont bien été prises en compte.' }
        format.json { render :show, status: :ok, location: epreuves_path }
      else
        format.html { render :index }
        format.json { render json: @epreuve.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /epreuves/1
  # DELETE /epreuves/1.json
  def destroy
    @epreuve.resultats.each do |res|
      res.destroy
    end
    @epreuve.destroy
    respond_to do |format|
      format.html { redirect_to epreuves_url, alert: 'Votre épreuve a bien été supprimé.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_epreuve
      @epreuve = Epreuve.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def epreuve_params
      allow = [:titre, :date, :matiere_id]
      params.require(:epreuve).permit(allow)
    end
end
