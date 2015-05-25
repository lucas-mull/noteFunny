class Epreuve < ActiveRecord::Base
	belongs_to	:matiere
	has_many :resultats
end
