class Appartenance < ActiveRecord::Base
	belongs_to :matieres
	belongs_to :etudiants

	class << self
		def getMatieresFromEtu(etu_id)
			list = Array.new
			appartenances = Appartenance.where(etudiants_id: etu_id).find_each	do |a|
				list << Matiere.find(a.matieres_id)
			end
			return list
		end

		def getEtusFromMatiere(matiere_id)
			list = Array.new
			appartenances = Appartenance.where(matieres_id: matiere_id).find_each	do |a|
				list << Utilisateur.find(a.etudiants_id)
			end
			return list
		end

		def deleteAllFromMatiere(matiere_id)
			appartenances = Appartenance.where(matieres_id: matiere_id).find_each	do |a|
				a.destroy
			end
		end
	end
end
