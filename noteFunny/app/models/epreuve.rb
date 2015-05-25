class Epreuve < ActiveRecord::Base
	belongs_to	:matiere
	has_many :resultats

	after_save :create_results

	def create_results
		if (appartenances = self.matiere.appartenances)
			appartenances.each do |a|
				Resultat.create(:epreuve_id => self.id, :etudiant_id => a.etudiant_id)
			end
		end
	end
end
