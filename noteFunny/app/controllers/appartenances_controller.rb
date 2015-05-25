class AppartenancesController < ApplicationController
	def invite
		if Appartenance.checkForDuplicates(params[:matiere_id], params[:etudiant_id])
			respond_to do |format|
				format.html { redirect_to matiere_path(:id => current_matiere.id), notice: 'Cet étudiant est déjà inscrit à cette matière' }
	      		format.json { render :show, status: :created, location: matiere_path(:id => current_matiere.id) }
	      	end
		else
			@appartenance = Appartenance.new(appartenances_params)
			@user = Utilisateur.find(params[:etudiant_id])
			UserMailer.welcome_email(@user, params[:temp_password]).deliver_now
			respond_to do |format|
				if @appartenance.save
					format.html { redirect_to matiere_path(:id => current_matiere.id), notice: 'Invitation envoyée' }
		      		format.json { render :show, status: :created, location: matiere_path(:id => current_matiere.id) }
		      	end
	      	end
		end
		
	end

	def createList
  		etu_ids = params[:checked]
  		if etu_ids != nil
	  		matiere_id = current_matiere.id
	  		etu_ids.each do |id|
	  			if !Appartenance.checkForDuplicates(matiere_id, id)
		  			@appartenance = Appartenance.new(:matiere_id => matiere_id, :etudiant_id => id)
		  			@appartenance.save
		  		end
	  		end
	  		respond_to do |format|
				format.html { redirect_to matiere_path(:id => matiere_id), notice: 'Etudiants ajoutés' }
	      		format.json { render :show, status: :created, location: matiere_path(:id => matiere_id) }
	      	end
      	else
      		respond_to do |format|
				format.html { redirect_to add_etu_path, notice: 'Vous devez sélectionner au moins un étudiant !' }
	      		format.json { render :show, status: :created, location: matiere_path(:id => matiere_id) }
	      	end
      	end
	end

	private

	def appartenances_params
		allow = [:matiere_id, :etudiant_id]
		params.permit(allow)
	end
end
