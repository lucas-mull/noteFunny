class Enseignant < Utilisateur
	has_many :matieres

	validates :nom, :presence => true
	validates :prenom, :presence => true
	validates :email, :presence => true, :uniqueness => true
	validates :password, :presence => true
end
