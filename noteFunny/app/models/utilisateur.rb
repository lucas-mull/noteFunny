class Utilisateur < ActiveRecord::Base
	validates :nom, :presence => true
	validates :prenom, :presence => true
	validates :email, :presence => true, :uniqueness => true
	validates :password, :presence => true

	def fullname
		return prenom.to_s + " " + nom.to_s
	end
end
