class UserMailer < ApplicationMailer
	default from: 'no-reply@notefunny.fr'

	def welcome_email(user)
		@user = user
		@url = 'localhost:3000/confirm/' + @user.id.to_s
		mail(to: @user.email, subject: 'Bienvenue sur noteFunny !')
	end
end
