class Resultat < ActiveRecord::Base
	belongs_to: epreuves
	belongs_to: etudiants
end
