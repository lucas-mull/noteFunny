class Utilisateur < ActiveRecord::Base
	validates :nom, :presence => true
	validates :prenom, :presence => true
	validates :email, :presence => true
	validates :password, :presence => true
end
