class EpreuvesController < ApplicationController
  before_action :set_Epreuve, only: [:show, :edit, :update, :destroy]

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

  # GET /epreuves/1
  # GET /epreuves/1.json
  def show
  end

  # GET /epreuves/new
  def new
    @Epreuve = Epreuve.new
  end

  # GET /epreuves/1/edit
  def edit
  end

  # POST /epreuves
  # POST /epreuves.json
  def create
    @Epreuve = Epreuve.new(Epreuve_params)

    respond_to do |format|
      if @Epreuve.save
        format.html { redirect_to @Epreuve, notice: 'Epreuve was successfully created.' }
        format.json { render :show, status: :created, location: @Epreuve }
      else
        format.html { render :new }
        format.json { render json: @Epreuve.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /epreuves/1
  # PATCH/PUT /epreuves/1.json
  def update
    respond_to do |format|
      if @Epreuve.update(Epreuve_params)
        format.html { redirect_to @Epreuve, notice: 'Epreuve was successfully updated.' }
        format.json { render :show, status: :ok, location: @Epreuve }
      else
        format.html { render :edit }
        format.json { render json: @Epreuve.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /epreuves/1
  # DELETE /epreuves/1.json
  def destroy
    @Epreuve.destroy
    respond_to do |format|
      format.html { redirect_to epreuves_url, notice: 'Epreuve was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_Epreuve
      @Epreuve = Epreuve.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def Epreuve_params
      params[:Epreuve]
    end
end
