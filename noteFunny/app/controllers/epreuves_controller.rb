class EpreuvesController < ApplicationController
  before_action :set_epreuve, only: [:show, :edit, :update, :destroy]

  # GET /epreuves
  # GET /epreuves.json
  def index
    if isConnected?
      @utilisateur = current_user
      if @utilisateur.type == 'Admin'
        @epreuves = Epreuve.all
      elsif @utilisateur.type != 'Etudiant'
        @utilisateur.matieres.each do |m|
          @epreuves << m.epreuves
        end
      else
        @utilisateur.appartenances.matieres.each do |m|
          @epreuves << m.epreuves
        end
      end
    else
      redirect_to root_path
    end
  end

  def index_by
    if isConnected?
      @epreuves = Matiere.find(params[:matieres_id]).epreuves
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
    @epreuve.matieres_id = @matiere.id
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
        format.html { redirect_to @epreuve, notice: 'epreuve was successfully created.' }
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
        format.html { redirect_to @epreuve, notice: 'epreuve was successfully updated.' }
        format.json { render :show, status: :ok, location: @epreuve }
      else
        format.html { render :edit }
        format.json { render json: @epreuve.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /epreuves/1
  # DELETE /epreuves/1.json
  def destroy
    @epreuve.destroy
    respond_to do |format|
      format.html { redirect_to epreuves_url, notice: 'epreuve was successfully destroyed.' }
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
      allow = [:titre, :date, :matieres_id]
      params.require(:epreuve).permit(allow)
    end
end
