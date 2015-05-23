class Matiere < ActiveRecord::Base
	belongs_to :enseignants
	has_many :epreuves
	has_many :appartenances

	validates :enseignant_id, :presence => true
	validates :titre, :presence => true
	validates :debut, :presence => true
	validates :fin, :presence => true
end
