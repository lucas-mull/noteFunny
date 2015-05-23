class Epreuve < ActiveRecord::Base
	belongs_to	:matieres
	has_many :resultats
end
