class Resultat < ActiveRecord::Base
	belongs_to :epreuve
	belongs_to :etudiant

	validates :epreuve_id, :presence => "true"
	validates :etudiant_id, :presence => "true"
end
