class AppartenancesController < ApplicationController
	def create
		@appartenance = Appartenance.new(appartenances_params)
		@user = Utilisateur.find(params[:etudiants_id])
		UserMailer.welcome_email(@user).deliver_now
		respond_to do |format|
			if @appartenance.save
				format.html { redirect_to matiere_path(:id => current_matiere.id), notice: 'Invitation envoyée' }
	      		format.json { render :show, status: :created, location: matiere_path(:id => current_matiere.id) }
	      	end
      	end
	end

	private

	def appartenances_params
		allow = [:matieres_id, :etudiants_id]
		params.permit(allow)
	end
end
