class Matiere < ActiveRecord::Base
	belongs_to :enseignants
	has_many :epreuves
	has_many :appartenances
end
