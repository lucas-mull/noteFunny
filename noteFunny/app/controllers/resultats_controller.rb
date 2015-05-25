class ResultatsController < ApplicationController

	def create
		etu_ids = params[:etudiants_ids]
		if etu_ids != nil
			etu_ids.each do |id|
				@resultat = Resultat.new(:epreuve_id => current_epreuve.id, :etudiant_id => id)
				@resultat.save
			end
		end
		respond_to do |format|
			format.html { redirect_to epreuves_path, notice: 'L\'épreuve a été ajoutée avec succès.'}
			format.json { render :show, status: :created, location: epreuves_path }
		end

	end

	def show
		session[:current_epreuve_id] = params[:epreuve_id]
		@epreuve = current_epreuve
		@resultats = Resultat.where(epreuve_id: @epreuve.id)
	end

	def update
		@resultats = params[:resultats]
		@resultats.each do |couple|
			id, note = couple
			@resultat = Resultat.find(id)
			@resultat.update(:valeur => note)
		end
		respond_to do |format|
			format.html { redirect_to epreuves_path, notice: 'Notes enregistrées avec succès' }
        	format.json { render :show, status: :ok, location: epreuves_path }
    	end
	end

	private

	def resultats_params
		allow = [:epreuve_id, :etudiant_id]
		params.permit(allow)
	end
end
