class Utilisateur < ActiveRecord::Base

	has_secure_password

	validates :nom, :presence => true
	validates :prenom, :presence => true
	validates :email, :presence => true, :uniqueness => true
	validates :password, :presence => true, :if => :password

	def fullname
		return prenom.to_s + " " + nom.to_s
	end
end
