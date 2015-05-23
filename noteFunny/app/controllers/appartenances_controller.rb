class AppartenancesController < ApplicationController
	def invite
		if Appartenance.checkForDuplicates(params[:matières_id], params[:etudiants_id])
			respond_to do |format|
				format.html { redirect_to matiere_path(:id => current_matiere.id), notice: 'Cet étudiant est déjà inscrit à cette matière' }
	      		format.json { render :show, status: :created, location: matiere_path(:id => current_matiere.id) }
	      	end
		else
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
		
	end

	def create
		if Appartenance.checkForDuplicates(params[:matières_id], params[:etudiants_id])
			respond_to do |format|
				format.html { redirect_to matiere_path(:id => current_matiere.id), notice: 'Cet étudiant est déjà inscrit à cette matière' }
	      		format.json { render :show, status: :created, location: matiere_path(:id => current_matiere.id) }
	      	end
      	else
			@appartenance = Appartenance.new(appartenances_params)
			respond_to do |format|
				if @appartenance.save
					format.html { redirect_to matiere_path(:id => current_matiere.id), notice: 'Etudiant ajouté' }
		      		format.json { render :show, status: :created, location: matiere_path(:id => current_matiere.id) }
		      	end
	      	end
      	end
  	end

  	
  	class << self
  		def checkForDuplicates(mat_id, etu_id)
  			return Appartenance.where(:matières_id => mat_id, :etudiants_id => etu_id)
	  	end
  	end

	private

	def appartenances_params
		allow = [:matieres_id, :etudiants_id]
		params.permit(allow)
	end
end
