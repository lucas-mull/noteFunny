class Appartenance < ActiveRecord::Base
	belongs_to :matieres
	belongs_to :etudiants
end
