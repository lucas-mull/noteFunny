class Appartenance < ActiveRecord::Base
	belongs_to :matiere
	belongs_to :etudiant

	after_save	:create_results

	def create_results
		appartenances = Appartenance.where(etudiant_id: self.etudiant_id)
		appartenances.each do |a|
			if epreuves = Matiere.find(a.matiere_id).epreuves
				epreuves.each do |e|
					Resultat.create(:epreuve_id => e.id, :etudiant_id => self.etudiant_id)
				end
			end
		end
	end

	class << self
		def getMatieresFromEtu(etu_id)
			list = Array.new
			appartenances = Appartenance.where(etudiant_id: etu_id).find_each	do |a|
				list << Matiere.find(a.matiere_id)
			end
			return list
		end

		def getEtusFromMatiere(matiere_id)
			list = Array.new
			appartenances = Appartenance.where(matiere_id: matiere_id).find_each	do |a|
				list << Utilisateur.find(a.etudiant_id)
			end
			return list
		end

		def getIdsInMatiere(mat_id)
			id_list = Array.new
	  		appartenances = Appartenance.where(matiere_id: mat_id).find_each do |a|
	  			id_list << a.etudiant_id
	  		end
	  		return id_list
	  	end

	  	def checkForDuplicates(mat_id, etu_id)
  			if Appartenance.where(matiere_id: mat_id, etudiant_id: etu_id).count != 0
  				return true
  			else
  				return false
  			end
	  	end

		def deleteAllFromMatiere(matiere_id)
			appartenances = Appartenance.where(matiere_id: matiere_id).find_each	do |a|
				a.destroy
			end
		end
	end
end
