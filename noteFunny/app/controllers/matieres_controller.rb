class MatieresController < ApplicationController
  before_action :set_matiere, only: [:show, :edit, :update, :destroy]

  # GET /matieres
  # GET /matieres.json
  def index
    if isConnected?
      @user = current_user
      if @user.type == 'Admin'
        @matieres = Matiere.all
      elsif @user.type == 'Enseignant'
        @matieres = @user.matieres
      else
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

  # GET /matieres/1
  # GET /matieres/1.json
  def show
    @utilisateur = current_user
    session[:current_matiere_id] = @matiere.id
  end

  # GET /matieres/new
  def new
    @matiere = Matiere.new
    @utilisateur = current_user
    if @utilisateur.type != 'Admin'
      @matiere.enseignant_id = @utilisateur.id
    end
  end

  # GET /matieres/1/edit
  def edit
    @utilisateur = current_user
  end

  # POST /matieres
  # POST /matieres.json
  def create
    @matiere = Matiere.new(matiere_params)
    # @matiere.enseignant_id = current_user.id
    respond_to do |format|
      if @matiere.save
        format.html { redirect_to matieres_path, notice: 'Votre matiere a bien été modifié.' }
        format.json { render :show, status: :created, location: @matiere }
      else
        format.html { render :new }
        format.json { render json: @matiere.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /matieres/1
  # PATCH/PUT /matieres/1.json
  def update
    respond_to do |format|
      if @matiere.update(matiere_params)
        format.html { redirect_to @matiere, notice: 'La matière a été mise à jour.' }
        format.json { render :show, status: :ok, location: @matiere }
      else
        format.html { render :edit }
        format.json { render json: @matiere.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /matieres/1
  # DELETE /matieres/1.json
  def destroy
    @matiere.appartenances.each do |a|
      a.destroy
    end
    @matiere.epreuves.each do |e|
      e.destroy
    end
    @matiere.destroy
    respond_to do |format|
      format.html { redirect_to matieres_url, notice: 'Votre matiere a bien été supprimé.' }
      format.json { head :no_content }
    end
  end

  def add_student
    already_in = Appartenance.getIdsInMatiere(current_matiere.id)
    if already_in.count != 0
      @etudiants = Etudiant.where("id NOT IN (?)", already_in).sort_by{|etu| etu.nom}
    else
      @etudiants = Etudiant.all
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_matiere
      @matiere = Matiere.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def matiere_params
      allow = [:titre, :debut, :fin, :description, :enseignant_id]
      params.require(:matiere).permit(allow)
    end
end
