class Etudiant < Utilisateur
	has_many :appartenances
	has_many :resultats

	validates :nom, :presence => true
	validates :prenom, :presence => true
	validates :email, :presence => true, :uniqueness => true
	validates :password, :presence => true
end
