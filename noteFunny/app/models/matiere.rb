class Matiere < ActiveRecord::Base
	belongs_to :utilisateurs
	has_many :epreuves
	has_many :utilisateurs
end
